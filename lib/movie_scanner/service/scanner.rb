require 'parallel'
require 'ostruct'

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

        base_movies = names.map {|name| Domain::SourceData.new({:source => OpenStruct.new(:source_priority => 9999, :source_name => "Original"), :title => name}) }

        base_movies.map do |base_movie|
          # collect new data from sources
          enriched_data = @enrichers.map {|enricher| enricher.enrich_movie(base_movie.title) }.compact

          # add original data
          enriched_data << base_movie

          # merge all data into a movie object
          @merger.merge_to_movie(enriched_data)
        end.compact
      end
    end
  end
end