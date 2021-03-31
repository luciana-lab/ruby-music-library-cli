class MusicImporter

    #accepts a file path to parse MP3 files from
    def initialize(path)
        @path = path
    end

    #retrieves the path provided to the MusicImporter object
    def path
        @path
    end

    #loads all the MP3 files in the path directory
    #normalizes the filename to just the MP3 filename with no path
    def files
        Dir.entries(path).select {|mp3| File.file? File.join(path, mp3)}
    end

    #imports the files into the library by invoking Song.create_from_filename
    def import
        files.each {|filename| Song.create_from_filename(filename)}
    end
end