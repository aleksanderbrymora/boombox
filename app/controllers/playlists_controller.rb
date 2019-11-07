class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    @playlist_new = Playlist.new
    @songs_rand = Song.all.sample(5)
    # raise "hell"
    # TODO @featured_playlists
  end

  def new
  end

  def create
    playlist = Playlist.create playlist_params
    @current_user.playlists << playlist
    redirect_to playlist
  end

  def edit
  end

  def show
    @playlist = Playlist.find params[:id]
  end

  def destroy
    playlist = Playlist.find params[:id]
    playlist.songs.each {|song| playlist.songs.delete song.id}
    playlist.delete
    redirect_to playlists_path
  end

  def update
    playlist = Playlist.find params[:id]
    playlist.songs.delete params[:song_id]
    redirect_to playlist
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
