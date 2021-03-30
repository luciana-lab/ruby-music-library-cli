class Genre

    #extends the Concerns::Findable module
    extend Concerns::Findable

    #retrieves the name of a genre
    #can set the name of a genre
    attr_accessor :name, :artist

    #is initialized as an empty array
    @@all = []

    #accepts a name for the new genre
    def initialize(name)
        @name = name
    end

    #adds the Genre instance to the @@all class variable
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

    #initializes and saves the genre
    def self.create(genre)
        self.new(genre).tap do
            |genre| genre.save
        end
    end

    #returns the genre's 'songs' collection (genre has many songs
    def songs
        Song.all.select do |song|
            song.genre == self
        end
    end

    #returns a collection of artists for all of the genre's songs (genre has many artists through songs)
    #does not return duplicate artists if the genre has more than one song by a particular artist (genre has many artists through songs)
    def artists
        songs.collect {|song| song.artist}.uniq
    end
end