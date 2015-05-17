require_relative "movie_scanner/domain"
require_relative "movie_scanner/persistence"
require_relative "movie_scanner/service"
require_relative "movie_scanner/ui"

module MovieScanner
  class MovieScanner
    def initialize(input_dir, output_dir)
      # wire everything up
      @input_persistence = Persistence::FileSystem.new(input_dir)
      @output_persistence = Persistence::FileSystem.new(output_dir)
      @ui = UI::Html.new
      
      enrichers = [Service::Enrichment::OMDB.new, Service::Enrichment::RottenTomatoes.new]
      merger = Service::Merger.new
      @scanner = Service::Scanner.new(enrichers, merger, @input_persistence)
      
    end
    
    def run
      time = Time.now
      movies = @scanner.find_movies
      
      ui = @ui.create_ui(time, movies)
      
      @output_persistence.write(ui)
    end
  end
end

if __FILE__ == $0
  input_dir = ARGV[0]
  output_dir = ARGV[1]

  MovieScanner::MovieScanner.new(input_dir, output_dir).run
end

