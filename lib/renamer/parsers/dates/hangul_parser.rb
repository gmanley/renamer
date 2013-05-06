require 'renamer/parsers/base'
require 'renamer/core_ext/match_data'

module Renamer
  module Parsers
    module Dates
      class HangulParser
        include Base

        HANGUL_DATE_REGEX = /\[(?<year>\p{Hangul}+)\.(?<month>\p{Hangul}+)\.(?<day>\p{Hangul}+)\]/
        HANGUL_DATE_MAP = YAML.load_file(File.join(DATA_ROOT, 'hangul_dates.yml'))

        def parse
          Date.civil(*tokens)
        end

        def tokens
          if match = HANGUL_DATE_REGEX.match(input)
            match.to_h.collect do |type, token|
              Integer(HANGUL_DATE_MAP[type.to_s][token])
            end
          end
        end
      end
    end
  end
end
