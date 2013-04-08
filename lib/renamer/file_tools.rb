module Renamer
  module FileTools

    def video_file?(path)
      FileTest.file?(path) && VIDEO_EXTENSIONS.include?(File.extname(path).downcase)
    end

    def safe_move(from, to)
      from = File.expand_path(from)
      to = File.expand_path(to)
      target = File.join(to, File.basename(from))

      unless File.exist?(target)
        puts Differ.diff_by_char(File.basename(to), File.basename(Unicode.nfkc(from)))
        FileUtils.mv(from, to) unless DRY_RUN
      else
        puts "skipping #{from.inspect} because #{target.inspect} already exists"
      end
    end

    extend self
  end
end
