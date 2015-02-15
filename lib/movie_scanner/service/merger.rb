module MovieScanner
  module Service
    class Merger
      def merge_to_movie(source_data_items)
        # TODO - merge properly

        # for now, just take first data
        item = source_data_items[0]

        title = '(unknown)'
        genre = '(unknown)'

        if item.nil?
          nil
        else
          title = item.title unless item.title.nil?
          genre = item.genre unless item.genre.nil?
          Domain::Movie.new(title, genre, item.data)
        end
      end
    end
  end
end