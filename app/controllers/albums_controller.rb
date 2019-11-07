class AlbumsController < ApplicationController
  def index
    @featured_names = RSpotify::Playlist.search('Australia viral 50').first.tracks.map {|t| t.album.name}[0...1]
    @featured_images = @featured_names.map {|artist| RSpotify::Album.search(artist).first.images.first["url"]}
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
