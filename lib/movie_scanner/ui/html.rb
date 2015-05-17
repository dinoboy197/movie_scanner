module MovieScanner
  module UI
    # writes out information to HTML format
    class Html
      
      def create_ui(time, movies)
        {"index.html" => main_page(time, movies)}
      end
      
      private
      def main_page(time, movies)
        "<html><head><title>Movie Listing</title></head>#{show_body(time, movies)}"
      end
      
      def show_body(time, movies)
        "<body><h2>Taylor's Movies - Generated at #{time.strftime("%A, %b %e %Y, %r")}</h2><ul>#{movies.sort{|a,b| a.title <=> b.title }.map {|movie| show_movie(movie)}.join('')}</ul></body>"
      end
      
      def show_movie(movie)
        "<li><img src=\"#{movie.poster_url}\"></img> <strong>#{movie.title}</strong> - #{movie.genre} - #{movie.year} - #{movie.synopsis} - rating: #{movie.rating} - scores: #{movie.scores} - runtime: #{movie.runtime}</li>"
      end
    end
  end
end