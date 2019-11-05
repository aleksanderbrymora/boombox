class Artist < ApplicationRecord
	has_many :albums
	validates_presence_of :name, :presence => true, :uniqueness => true
end
