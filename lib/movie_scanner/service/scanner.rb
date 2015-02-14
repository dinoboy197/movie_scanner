module MovieScanner
  module Service
    class Scanner
      def initialize(persistence)
        @persistence = persistence
      end
      
      def find_movies
        names = @persistence.list_items
        
        names.map {|name| Domain::Movie.new(name) }
      end
    end
  end
end