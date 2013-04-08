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
      if match = HANGUL_DATE_REGEX.match(file_name)
        original_date, hangul_year, hangul_month, hangul_day = match.to_a
        date = Date.civil(HANGUL_DATE_TO_NUMERAL['year'][hangul_year],
          HANGUL_DATE_TO_NUMERAL['month'][hangul_month],
          HANGUL_DATE_TO_NUMERAL['day'][hangul_day]
        )

        replacements[match.to_s] = date.strftime(NUMERAL_DATE_FORMAT)
      end
    end

    def parse_numeral_date
      if match = NUMERAL_DATE_REGEX.match(file_name)
        # TODO: Need to refactor this... too many assumptions about year
        year = match[:year].length == 2 ? '20' + match[:year] : match[:year]
        date = Date.civil(year.to_i, match[:month].to_i, match[:day].to_i)

        replacements[match.to_s] = date.strftime(NUMERAL_DATE_FORMAT)
      end
    end

    def normalized_event
      EVENT_NAMES.find do |normalized_event, possible_events|
        possible_events.any? { |possible_event| @file_name.include?(@original_event = possible_event) }
      end.first
    end
  end
end
