class Song
    #retrieves the name of a song
    #can set the name of a song
    #returns the artist of the song (song belongs to artist)
    #assigns an artist to the song (song belongs to artist)
    #returns the genre of the song (song belongs to genre)
    #assigns a genre to the song (song belongs to genre)
    #adds the song to the genre's collection of songs (genre has many songs)
    attr_accessor :name, :artist, :genre

    #is initialized as an empty array
    @@all = []

    #accepts a name for the new song
    #can be invoked with an optional second argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist)
    #can be invoked with an optional third argument, a Genre object to be assigned to the song's 'genre' property (song belongs to genre)
    def initialize(name, artist = nil, genre = nil)
        @name = name
        #invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
        self.artist=(artist) if artist != nil
        
        #invokes #genre= instead of simply assigning to a @genre instance variable to ensure that associations are created upon initialization
        self.genre=(genre) if genre != nil
    end

    #adds the Song instance to the @@all class variable
    def save
        @@all << self
    end

    #returns the class variable @@all
    def self.all
        @@all
    end

    #resets the @@all class variable to an empty array
    def self.destroy_all
        @@all.clear
    end

    #initializes, saves, and returns the song
    def self.create(song)
        self.new(song).tap do
            |song| song.save
        end
    end

    #invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    #does not add the song to the genre's collection of songs if it already exists therein (FAILED - 14)
    def genre=(genre)
        @genre = genre 
        genre.songs << self unless genre.songs.include?(self)
    end

    #finds a song instance in @@all by the name property of the song
    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    #returns (does not recreate) an existing song with the provided name if one exists in @@all
    #invokes .find_by_name instead of re-coding the same functionality
    #creates a song if an existing match is not found
    #invokes .create instead of re-coding the same functionality
    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    #initializes a song based on the passed-in filename
    #invokes the appropriate Findable methods so as to avoid duplicating objects
    def self.new_from_filename(filename)
        file = filename.split(" - ")
        song_name = file[1]
        artist_name = file[0]
        genre_name = file[2].split(".mp3").join
        
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
    end

    #initializes and saves a song based on the passed-in filename
    #invokes .new_from_filename instead of re-coding the same functionality
    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
end