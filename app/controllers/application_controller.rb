class ApplicationController < ActionController::Base
	before_action :fetch_user

	######### Featured stuff ############################
	# Returns top 12 songs from popular playlist
	def featured_tracks
		RSpotify::Playlist.search('top')[0...12].sample.tracks[0...12]
	end

	def featured_albums
		album_data = {:title => nil, :image => nil, :artist => nil}
		tracks = featured_tracks
		album_data[:title] = tracks.map {|t| t.album.name}
		album_data[:image] = tracks.map {|t| t.album.images.first["url"]}
		album_data[:artist] = tracks.map {|t| t.artists.first.name}
		return album_data
	end

	def featured_artists
		artist_data = {:name => nil, :image => nil}
		tracks = featured_tracks
		artist_data[:name] = tracks.map {|t| t.artists.first.name}
		artist_data[:image] = tracks.map {|t| t.artists.first.images.first["url"]}
		return artist_data
	end

	# TODO Function that 
	## loops through all results for an artist
	## checks if passed album is present inside
	### If not goes into another artist untill it finds him
	# Returns Artist's and album's spotify id

	def s_find_album_artist artist_name, album_name
		album_data = {:album_id => nil, :artist_id => nil}
		artists = RSpotify::Artist.search(artist_name)
		artists.each do |artist|
			artist.albums.each do |album| 
				if album.name.downcase.tr('^A-Za-z', '') == album_name.downcase.tr('^A-Za-z', '')
					album_data[:album_id] = album.id
					album_data[:artist_id] = artist.id
					break
				end
			end
		end
		return album_data
	end

	# returns full info, name, photo
	def s_artist id
		artist_data = {:full => nil, :name => nil, :image => nil}
		artist_data[:full] = RSpotify::Artist.find(id)
		unless artist_data[:full] == nil
			artist_data[:name] = artist_data[:full].name
			artist_data[:image] = artist_data[:full].images.first["url"]
		end
		return artist_data
	end

	def s_artist_find name
		artist_id = (RSpotify::Artist.search(name)).first.id
		s_artist artist_id
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
	def s_album id
		album_data = {:full => nil, :name => nil, :image => nil, :tracks => nil}
		album_data[:full] = RSpotify::Album.find(id)
		unless album_data[:full] == nil
			album_data[:name] = album_data[:full].name
			album_data[:image] = album_data[:full].images.first["url"]
			album_data[:tracks] = album_data[:full].tracks.map {|t| t.name}
		end
		return album_data
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
			album_data = s_find_album_artist artist_name, album_name
			album = s_album album_data[:album_id]
			artist = s_artist album_data[:artist_id]
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
