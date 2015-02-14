require_relative "movie_scanner/service"
require_relative "movie_scanner/persistence"
require_relative "movie_scanner/ui"

module MovieScanner
  class MovieScanner
    def initialize(file_dir)
      # wire everything up
      @persistence = Persistence::FileSystem.new(file_dir)
      @ui = UI::Html.new
      
      @scanner = Service::Scanner.new
      
    end
    
    def run
      movies = @scanner.find_movies
      
      ui = @ui.create_ui(movies)
      
      @persistence.write(ui)
    end
  end
end

if __FILE__ == $0
  file_dir = ARGV[0]
  puts file_dir

  MovieScanner::MovieScanner.new(file_dir).run
end

