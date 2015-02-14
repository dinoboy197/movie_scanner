require 'ice_nine'

module MovieScanner
  module Domain
    class Movie
      attr_reader :name
      
      def initialize(name)
        @name = name
        IceNine.deep_freeze(self)
      end
    end
  end
end