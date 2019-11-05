class PagesController < ApplicationController
  def home
    featured = RSpotify::Playlist.browse_featured(country: 'US');
    @top_names_title = featured.first.tracks.map {|x| x.name}[0...6]
    @top_names_artist = featured.first.tracks.map {|x| x.artists.first.name}[0...8]
    @top_images = featured.first.tracks.map {|x| x.album.images.first["url"]}[0...8]
  end
end
