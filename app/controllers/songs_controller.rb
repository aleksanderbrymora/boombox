class SongsController < ApplicationController
  def create
  end

  def add
    song = Song.find params[:song_id]
    params[:playlist_ids].each do |id|
      song.playlists << Playlist.find(id)
    end
    redirect_to playlists_path
  end
end