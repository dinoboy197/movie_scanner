require 'ice_nine'

module MovieScanner
  module Domain
    class SourceData
      attr_reader :priority
      attr_reader :source
      attr_reader :title
      attr_reader :genre
      attr_reader :synopsis
      attr_reader :year
      attr_reader :score
      attr_reader :rating
      attr_reader :runtime
      attr_reader :poster_url

      def initialize(data)
        @source = data[:source]
        @title = data[:title]
        @genre = data[:genre]
        @synopsis = data[:synopsis]
        @year = data[:year]
        @rating = data[:rating]
        @score = data[:score]
        @runtime = data[:runtime]
        @poster_url = data[:poster_url]
        IceNine.deep_freeze(self)
      end
    end
  end
end