class Artist

    #extends the Concerns::Findable module
    extend Concerns::Findable

    #retrieves the name of an artist
    #can set the name of an artist
    attr_accessor :name, :song

    #is initialized as an empty array
    @@all = []

    #accepts a name for the new artist
    def initialize(name)
        @name = name
        @songs = []
    end

    #adds the Artist instance to the @@all class variable
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

    #initializes and saves the artist
    def self.create(artist)
        self.new(artist).tap do
            |artist| artist.save
        end
    end

    #returns the artist's 'songs' collection
    def songs
        Song.all.select {|song| song.artist == self}
    end

    #assigns the current artist to the song's 'artist' property (song belongs to artist)
    #does not assign the artist if the song already has an artist
    #adds the song to the current artist's 'songs' collection
    #does not add the song to the current artist's collection of songs if it already exists therein
    def add_song(song)
        if song.artist == nil 
           song.artist = self
        else
            nil
        end

        if @songs.include?(song)
            nil
        else
            @songs << song
        end
        song
    end

    #returns a collection of genres for all of the artist's songs (artist has many genres through songs)
    #does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs)
    def genres
        songs.collect {|song| song.genre}.uniq
    end
end