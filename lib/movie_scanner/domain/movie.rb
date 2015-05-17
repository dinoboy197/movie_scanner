require 'ice_nine'

module MovieScanner
  module Domain
    class Movie
      attr_reader :title
      attr_reader :genre
      attr_reader :year
      attr_reader :synopsis
      attr_reader :rating
      attr_reader :scores
      attr_reader :runtime
      attr_reader :poster_url
      
      def initialize(title, genre, year, synopsis, rating, scores, runtime, poster_url)
        raise "Title is blank!" if title.to_s.empty?
        raise "Genre is blank!" if genre.to_s.empty?
        @title = title
        @genre = genre
        @year = year
        @synopsis = synopsis
        @rating = rating
        @scores = scores
        @runtime = runtime
        @poster_url = poster_url
        IceNine.deep_freeze(self)
      end
    end
  end
end