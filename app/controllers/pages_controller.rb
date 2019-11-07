class PagesController < ApplicationController
  def home
    @featured_tracks = RSpotify::Playlist.browse_featured(country: 'US').first.tracks[0...16];
    @featured_names = @featured_tracks.map {|x| x.name}
    @featured_artist = @featured_tracks.map {|x| x.artists.first.name}
    @featured_images = @featured_tracks.map {|x| x.album.images.first["url"]}
  end
end
