class Album < ApplicationRecord
	has_many :songs
	validates_presence_of :title, :presence => true, :uniqueness => true
end
