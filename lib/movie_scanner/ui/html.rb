module MovieScanner
  module UI
    # writes out information to HTML format
    class Html
      
      def create_ui(movies)
        {"index.html" => main_page(movies)}
      end
      
      private
      def main_page(movies)
        "<html><head><title>Movie Listing</title></head>#{show_body(movies)}"
      end
      
      def show_body(movies)
        "<body><ul>#{movies.map {|movie| show_movie(movie)}.join('')}</ul></body>"
      end
      
      def show_movie(movie)
        "<li>#{movie.title}</li>"
      end
    end
  end
end