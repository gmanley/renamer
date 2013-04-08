module Renamer
  class FileRenamer
    attr_accessor :new_name, :name

    def initialize(path, new_name = nil)
      @path = Pathname(path)
      @name = Unicode.nfkc(@path.basename.to_s) # http://en.wikipedia.org/wiki/Compatibility_decomposition#Normalization
      @new_name = new_name
    end

    def parser
      @parsed_filename ||= ParsedFilename.new(@name)
    end

    def no_change?
      @name.eql?(@new_name)
    end

    def rename!
      unless no_change?
        FileTools.safe_move(@path.to_s, @path.dirname.join(@new_name).to_s)
      end
    end
  end
end
