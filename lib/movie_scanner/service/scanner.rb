module MovieScanner
  module Service
    class Scanner
      def initialize(enrichers, merger, persistence)
        @enrichers = enrichers
        @merger = merger
        @persistence = persistence
      end

      def find_movies
        names = @persistence.list_items

        names.map do |name|
          enriched_data = @enrichers.map {|enricher| enricher.enrich_movie(name) }
            
          @merger.merge_to_movie(enriched_data)
        end
      end
    end
  end
end