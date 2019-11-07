class ArtistsController < ApplicationController
  def index
    artist_data = featured_artists
    @featured_names = artist_data[:name]
    @featured_images = artist_data[:image]
    @artists_in_db = Artist.all
    @artist = Artist.new
    @albums = @artist.albums.map {|a| a.title}
  end

  def create
    artist_data = s_artist_find params[:name]
    name = artist_data[:name]
    if Artist.find_by :name => name 
      redirect_to Artist.find_by :name => name 
    else
      image = artist_data[:image]
      artist = Artist.create :name => name, :image => image
      redirect_to artist
    end
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

  # private
  # def artist_params
  #   params.require(:artist).permit(:name)
  # end
end
