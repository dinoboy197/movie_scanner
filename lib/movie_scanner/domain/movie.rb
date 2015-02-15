require 'ice_nine'

module MovieScanner
  module Domain
    class Movie
      attr_reader :title
      attr_reader :genre
      
      def initialize(title, genre, data)
        raise "Title is blank!" if title.to_s.empty?
        raise "Genre is blank!" if genre.to_s.empty?
        @title = title
        @genre = genre
        @data = data
        IceNine.deep_freeze(self)
      end
    end
  end
end