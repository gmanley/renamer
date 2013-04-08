require 'renamer/parsed_filename'

module Renamer
 class VideoScanner

    def initialize(path)
      @path = path
    end

    def video_files
      Find.find(@path).find_all { |path| FileTools.video_file?(path) }
    end

    def rename!
      renames = 0
      video_files.each do |f|
        renamer = FileRenamer.new(f)
        file_name = renamer.name
        parsed_video = renamer.parser

        if parsed_video.normalized_date
          new_file_name = "[#{parsed_video.normalized_date}] #{file_name.gsub(parsed_video.original_date.to_s, '')}"
        else
          new_file_name = parsed_video.file_name
        end

        renamer.new_name = new_file_name#.gsub(/\.tp$/, '.ts').gsub(/(\[\]|\(\))/, '').gsub('  ', ' ').gsub('SBS SBS', 'SBS')

        unless renamer.no_change?
          renamer.rename!
          renames += 1
        end
      end

      puts "#{@renames} total renames!"
    end
  end
end
