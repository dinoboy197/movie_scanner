require 'ice_nine'

module MovieScanner
  module Domain
    class Movie
      attr_reader :title
      attr_reader :genre
      
      def initialize(title, genre, data)
        @title = title
        @genre = genre
        @data = data
        IceNine.deep_freeze(self)
      end
    end
  end
end