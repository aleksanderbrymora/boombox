# Boombox

[Deployed website](https://boomboxv2-unique.herokuapp.com/)

## Showcase

![Showcase](https://images.ctfassets.net/02g4788riobs/2QiuJoSBtxJGJwX6Sp5Ebp/201155b3cbb8024057fb34b823eff14e/Boombox.gif)

For this project I have created a database to store albums, artists and songs given by user. I utilised Spotify's API to get data and images into my database.

I have 5 models which include:
- Albums
- Artists
- Playlists
- Songs
- Users

I created less views than we would normally do. I ommitted views for new and edit page for most od the models, because logically you couldn't edit someones album ar name. You can edit a playlist though, but is still happens in the playlist-show view. There is no view for songs, as they all appear in the album view.
Additions to database happen in the new page where I have added fields to add new items.

All user input is "sanitized" by Spotify search. Nothing goes through straight to the database. Ie when user inputs a name of an artist, the name is sent to Spotify's database to get the appropriate formating and also other data including pictures, albums and tracks.

When adding an artist this information is pulled from Spotify:
- Name
- Image

When adding an album this information is pulled from Spotify:
- Title
- Artist's name
- Image
- Songs

When adding an album the test is run to create an artist if he's not present in the Database, and if so hes added. Also all the songs are pulled and associated with the album.

User can create playlists and add songs to them through either in the album show view or suggestions from the songs in the database.
Song can be added to multiple playlists at once.

Most index views include a plus button to add featured album/artist to your library through one click. These suggestions are pulled straight from one of featured playlists on Spotify.

## Gems I used
- RSpotify
- HTTParty
- Table-print

 Gems I planned to use
 - PG-Search - for universal search through the whole library
 - Cloudinary - For uploading Users photos and playlist covers

# Add-ons
Used bootstrap for whole website

# What I would do differently
Having a week for a project leaves a pretty small time for correcting an error especially when you see it down the end. That said last two days of the project were mostly spent on patching my old code to work with new features. It wasnt thought through well enough in the beginning.
Things I would change: 
- Rework a search for artists - have a user choose from a dropdown list exactly which artist they want, not taking the first result from the search in spotify playlist.
- doing the same for the albums search - though this search works much better than the one for artists, because it has more data to work with, it also fails sometimes and adds a random artist
- I'd start over from scratch and use partials, because code with bootstrap gets sooooo messy and nested. I'd also build the search functions in Spotify first to make sure they are robust and reusable. Which is not the approach I had taken during this project, where I wrote functions sepcific for the views, which led to messy code (though i reworked most of it later)
- And the main thing - just plan it out better. I wasn't sure most of the way what am I aiming for, the goal wasn't clear. That's where the confusion came from and lack of propper goals lead to lots of waisted time.
