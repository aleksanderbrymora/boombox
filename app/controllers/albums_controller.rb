class AlbumsController < ApplicationController
  def index
    album_data = featured_albums
    @featured_tracks = album_data[:title]
    @featured_names = album_data[:title]
    @featured_images = album_data[:image]
    @featured_artist = album_data[:artist]
    @albums_in_db = Album.all
    @album = Album.new
  end

  def create
    album_artist params[:title], params[:artist]
  end

  def edit
  end

  def show
    @album = Album.find params[:id]
    @artist = Artist.find @album.artist_id
    @songs = @album.songs
    @playlists = Playlist.all
  end

  def destroy
    album = Album.find params[:id]
    album.songs.destroy_all
    album.destroy
    redirect_to albums_path
  end
end
