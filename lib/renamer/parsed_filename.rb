module Renamer
  class ParsedFilename
    attr_reader :file_name, :replacements

    def initialize(file_name)
      @file_name = file_name
      @replacements = {}
    end

    def normalized_date
      @normalized_date ||= parse_hangul_date || parse_numeral_date
    end

    def parse_hangul_date
      parser = Parsers::Date::HangulParser.new(file_name)
      replacements[parser.original_date] = parser.parsed_date.strftime(NUMERAL_DATE_FORMAT)
    rescue => e
      Renamer.logger.info(e.to_s)
      Renamer.logger.debug(e.backtrace)
      nil
    end

    def parse_numeral_date
      parser = Parsers::Date::NumeralParser.new(file_name)
      replacements[parser.original_date] = parser.parsed_date.strftime(NUMERAL_DATE_FORMAT)
    rescue => e
      Renamer.logger.info(e.to_s)
      Renamer.logger.debug(e.backtrace)
      nil
    end
  end
end
