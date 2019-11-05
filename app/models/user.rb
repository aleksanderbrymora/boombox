class User < ApplicationRecord
	has_many :playlists
	has_secure_password

	validates :email, :presence => true, :uniqueness => true
end
