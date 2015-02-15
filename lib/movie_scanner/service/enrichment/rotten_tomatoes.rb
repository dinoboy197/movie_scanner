require 'damerau-levenshtein'
require 'rottentomatoes'
include RottenTomatoes

module MovieScanner
  module Service
    module Enrichment
      class RottenTomatoes
        def initialize
          # TODO - put this in config
          Rotten.api_key = 'g2vbvbndq9fxxswztsxz6zyf'
          @dl = DamerauLevenshtein
        end

        def source_priority
          1
        end

        def enrich_movie(title)
          # find many items
          results = RottenMovie.find(:title => title, :limit => 10)

          if results.size == 0
            return nil
          end

          best_result = nil

          if results.is_a? Array
            # find the one closest to the title by Levenshtein distance
            sorted_results = results.sort {|a,b| @dl.distance(title, a.title) <=> @dl.distance(title, b.title) }

            # best result
            best_result = sorted_results[0]
          else
            best_result = results
          end

          #@movie.ratings.critics_score
          #@movie.synopsis

          Domain::SourceData.new(:"Rotten Tomatoes", best_result.title, nil, nil)
        end
      end
    end
  end
end