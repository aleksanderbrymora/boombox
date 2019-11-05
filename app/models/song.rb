class Song < ApplicationRecord
	belongs_to :album, :optional => true
	has_and_belongs_to_many :playlists
end
