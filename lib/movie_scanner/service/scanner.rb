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

        my_sources = names.map {|name| Domain::SourceData.new('Taylor', name, nil, nil) }

        my_sources.map do |my_source|
          # collect new data from sources
          enriched_data = @enrichers.map {|enricher| enricher.enrich_movie(my_source.title) }.compact

          # add original data
          enriched_data = enriched_data.push(my_source)

          @merger.merge_to_movie(enriched_data)
        end.compact
      end
    end
  end
end