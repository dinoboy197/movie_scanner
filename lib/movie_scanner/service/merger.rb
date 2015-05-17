module MovieScanner
  module Service
    class Merger
      def merge_to_movie(source_data)
        # merge field by field with priority

        # TODO - priority on a field by field basis
        # need to QA each data field for each source to determine which fields are most trustworthy

        title = '(unknown)'
        genre = '(unknown)'
        synopsis = ''
        year = ''
        rating = ''
        runtime = -1
        scores = {}
        poster_url = ''

        # iterate over all source data and fill in empty fields
        source_data.sort {|x| x.source.source_priority }.each do |item|
          title = item.title unless item.title.nil? || item.title.empty?
          genre = item.genre unless item.genre.nil? || item.genre.empty?
          synopsis = item.synopsis unless item.synopsis.nil? || item.synopsis.empty?
          year = item.year unless item.year.nil?
          rating = item.rating unless item.rating.nil? || item.rating.empty?
          runtime = item.runtime unless item.runtime.nil?
          scores.merge!({item.source.source_name => item.score}) unless item.score.nil?
          poster_url = item.poster_url unless item.poster_url.nil? || item.poster_url.empty?
        end

        # construct the Movie object from merged data
        Domain::Movie.new(title, genre, year, synopsis, rating, scores, runtime, poster_url)
      end
    end
  end
end