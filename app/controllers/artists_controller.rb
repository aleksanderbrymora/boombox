class ArtistsController < ApplicationController
  def index
    @featured_names = RSpotify::Playlist.search('Australia top 50').first.tracks.map {|t| t.artists.first.name}[0...12]
    @featured_images = @featured_names.map {|artist| RSpotify::Artist.search(artist).first.images.first["url"]}
    @artists_in_db = Artist.all
  end

  def new
  end

  def create
  end

  def show
  end
end
