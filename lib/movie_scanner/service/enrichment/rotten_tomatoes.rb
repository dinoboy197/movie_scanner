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
          20
        end
        
        def source_name
          "Rotten Tomatoes"
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
          
          score = best_result.ratings.critics_score

          Domain::SourceData.new({
            :source => self, 
            :title => best_result.title,
            :year => best_result.year,
            :synopsis => best_result.synopsis,
            :rating => best_result.mpaa_rating,
            :runtime => best_result.runtime,
            :poster_url => best_result.posters.profile,
            # choose the critics score over the audience score - 
            # had to make a choice if a source can only provide one rating
            :score => (score > 0 && best_result.ratings.critics_score) || nil
          })
        end
      end
    end
  end
end