class ApplicationController < ActionController::Base
	before_action :fetch_user

	# returns full info, name, photo
	def s_artist album
		artist_data = {:full => nil, :name => nil, :image => nil}

		if album.present?
			artist_data[:full] = album[:full].artists.first
		end
		
		unless artist_data[:full] == nil
			artist_data[:name] = artist_data[:full].name
			artist_data[:image] = (RSpotify::Artist.find(artist_data[:full].id)).images.first["url"]
		end
		artist_data
	end

	# returns isPresent in db and where for artist
	def db_artist name
		Artist.find_by :name => name
	end
	
	# returns isPresent in db and where for album
	def db_album name

		Album.find_by :title => name
	end

	# returns necesary album info
	def s_album name
		album_data = {:full => nil, :name => nil, :image => nil, :tracks => nil}

		unless name == ""
			album = RSpotify::Album.search(name)
			if album.length > 0
				album_data[:full] = album.first
			end
		end

		unless album_data == nil
			album_data[:name] = album_data[:full].name
			album_data[:image] = album_data[:full].images.first["url"]
			album_data[:tracks] = album_data[:full].tracks.map {|t| t.name}
		end
		album_data
	end

	# adding tracks to the album
	def db_songs album
		album_id = db_album album[:name]
		album_id = album_id[:id]
		puts "Album id is #{album_id}"
		# raise "hell"
		album[:tracks].each do |t|
			puts t
			Song.create :title => t, :album_id => album_id
		end
	end


	# album + artist
	# Decides if its necessary to add new artist when adding an album
	# Adds an album to db with optional new artist or appends to matching artist
	def album_artist album_name, artist_name
		album_name.downcase!
		artist_name.downcase!
		# checking if album is present in the db
		unless db_album album_name == nil
			album = s_album album_name
			artist = s_artist album
			# checking if search for Artist succeeded
			unless artist[:full] == nil
				artist_db = db_artist artist[:name]
				# checking if artist already exists
				unless artist_db == nil
					# creating an album and adding found artist id
					album_create = Album.create :title => album[:name], :image => album[:image], :artist_id => artist_db[:id]
				else
					# Creating an artist and then giving him the album
					new_artist = Artist.create :name => artist[:name], :image => artist[:image]
					album_create = Album.create :title => album[:name], :image => album[:image], :artist_id => new_artist[:id]
				end
				db_songs album
				redirect_to album_create
			end
		end
	end

	private
	def fetch_user
		@current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
		session[:user_id] = nil unless @current_user.present?
	end

	def check_for_login
		redirect_to login_path unless @current_user.present?
	end
end
