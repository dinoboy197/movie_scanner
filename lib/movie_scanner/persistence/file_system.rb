module MovieScanner
  module Persistence
    # writes out information to Files
    class FileSystem
      def initialize(directory)
        if directory.nil?
          raise "Directory was missing"
        end
        unless Dir.exist?(directory)
          raise "Directory #{directory} does not exist"
        end

        @directory = directory
        freeze
      end
      
      def list_items
        Dir.glob("#{@directory}/*").map {|x| File.basename(x, '.*') }
      end
      
      def write(ui)
        ui.each do |file,content|
          File.open(File.join(@directory,file),'w') do |f|
            f.write(content)
          end
        end
      end
    end
  end
end