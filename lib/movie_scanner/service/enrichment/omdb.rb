require 'damerau-levenshtein'
require 'json'
require 'net/http'
require 'cgi'

module MovieScanner
  module Service
    module Enrichment
      class OMDB
        def initialize
          @dl = DamerauLevenshtein
        end

        def source_priority
          10
        end
        
        def source_name
          "OMDB"
        end

        def enrich_movie(title)
          # imdb has their own matching service - only one item will be returned
          resp = Net::HTTP.get_response(URI.parse("http://www.omdbapi.com/?t=#{CGI::escape(title)}&y=&plot=short&r=json"))
          data = resp.body

          best_result = JSON.parse(data)

          if best_result["Response"] == "False"
            nil
          end

          Domain::SourceData.new({
            :source => self, 
            :title => best_result["Title"],
            :genre => best_result["Genre"],
            :year => best_result["Year"].to_i,
            :synopsis => best_result["Plot"],
            :rating => best_result["Rated"],
            :runtime => best_result["Runtime"].to_i,
            # don't include imdb urls, we can't access them from a different host
            :poster_url => best_result["Poster"].include?("imdb.com") ? nil : best_result["Poster"],
            :score => best_result["Metascore"].to_i
          })
        end
      end
    end
  end
end