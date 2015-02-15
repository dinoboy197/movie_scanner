module MovieScanner
  module Service
    class Merger
      def merge_to_movie(source_data_items)
        # TODO - merge properly

        # for now, just take first data
        Domain::Movie.new(source_data_items[0].title, source_data_items[0].genre, source_data_items[0].data)
      end
    end
  end
end