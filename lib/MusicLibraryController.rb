#Couldn't resolve it by myself at all! Used https://github.com/emilyjennings/ruby-music-library-cli-flatiron/blob/master/lib/MusicLibraryController.rb
class MusicLibraryController

    #accepts one argument, the path to the MP3 files to be imported
    #the 'path' argument defaults to './db/mp3s'
    def initialize(path = './db/mp3s')
        #creates a new MusicImporter object, passing in the 'path' value
        #invokes the #import method on the created MusicImporter object
        MusicImporter.new(path).import
    end

    def call

       #asks the user for input
       input = ""

       #loops and asks for user input until they type in exit
       while input != "exit"

       #welcomes the user
       puts "Welcome to your music library!"
       puts "To list all of your songs, enter 'list songs'."
       puts "To list all of the artists in your library, enter 'list artists'."
       puts "To list all of the genres in your library, enter 'list genres'."
       puts "To list all of the songs by a particular artist, enter 'list artist'."
       puts "To list all of the songs of a particular genre, enter 'list genre'."
       puts "To play a song, enter 'play song'."
       puts "To quit, type 'exit'."
       puts "What would you like to do?"

       input = gets.strip
       
       case input

        #triggers #list_songs
        when "list songs"
            list_songs

        #triggers #list_artists
        when "list artists"
            list_artists

        #triggers #list_genres
        when "list genres"
            list_genres

        #triggers #list_songs_by_artist
        when "list artist"
            list_songs_by_artist

        #triggers #list_songs_by_genre
        when "list genre"
            list_songs_by_genre
        when "play song"

        #triggers #play_song
            play_song
        when "quit"
            exit
        end
       end
    end

    #prints all songs in the music library in a numbered list (alphabetized by song name)
    #is not hard-coded
    def list_songs
        Song.all.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    #prints all artists in the music library in a numbered list (alphabetized by artist name)
    #is not hard-coded
    def list_artists
        Artist.all.sort {|a, b| a.name <=> b.name}.each_with_index do |artist, index|
            puts "#{index+1}. #{artist.name}"
        end
    end

    #prints all genres in the music library in a numbered list (alphabetized by genre name)
    #is not hard-coded
    def list_genres
        Genre.all.sort {|a, b| a.name <=> b.name}.each_with_index do |genre, index|
            puts "#{index+1}. #{genre.name}"
        end
    end

    #prompts the user to enter an artist
    #accepts user input
    #prints all songs by a particular artist in a numbered list (alphabetized by song name)
    #does nothing if no matching artist is found
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
                puts "#{index+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    #prompts the user to enter a genre
    #accepts user input
    #prints all songs by a particular genre in a numbered list (alphabetized by song name)
    #does nothing if no matching genre is found
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
                puts "#{index+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    #prompts the user to choose a song from the alphabetized list output by #list_songs
    #accepts user input
    #upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
    #does not 'puts' anything out if a matching song is not found
    #checks that the user entered a number between 1 and the total number of songs in the library
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if input > 0 && input <= Song.all.length
            array = Song.all.sort {|a, b| a.name <=> b.name}
            song = array[input-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end
