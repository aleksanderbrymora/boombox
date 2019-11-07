class ArtistsController < ApplicationController
  def index
    @featured_names = RSpotify::Playlist.search('Australia top 50').first.tracks.map {|t| t.artists.first.name}[0...1]
    @featured_images = @featured_names.map {|artist| RSpotify::Artist.search(artist).first.images.first["url"]}
    @artists_in_db = Artist.all
    @artist = Artist.new
    @albums = @artist.albums.map {|a| a.title}
  end

  def create
    if artist_params.permitted?
      artist_data = s_artist artist_params["name"]
      name = artist_data[:name]
      image = artist_data[:image]
      artist = Artist.create :name => name, :image => image
    end
    redirect_to artist
  end

  def show
    @artist = Artist.find params[:id]
  end

  def destroy
    artist = Artist.find params[:id]
    artist.albums.each do |a| 
      a.songs.destroy_all
      a.destroy
    end
    artist.delete
    redirect_to artists_path
  end

  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
