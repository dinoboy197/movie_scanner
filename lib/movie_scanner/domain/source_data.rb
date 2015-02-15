require 'ice_nine'

module MovieScanner
  module Domain
    class SourceData
      attr_reader :source
      attr_reader :title
      attr_reader :genre
      attr_reader :data

      def initialize(source, title, genre, data)
        @source = source
        @title = title
        @genre = genre
        @data = data
        IceNine.deep_freeze(self)
      end
    end
  end
end