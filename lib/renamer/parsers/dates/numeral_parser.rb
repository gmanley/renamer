require 'renamer/parsers/base'

module Renamer
  module Parsers
    module Dates
      class NumeralParser
        include Base

        VALID_YEAR_RANGE = 2007..2013
        VALID_DATE_SEPARATORS = %w(. - / _)

        def parse
          Date.civil(*tokens)
        end

        def tokens
          if match = numeral_date_regex.match(input)
            captures = match.captures
            captures.delete(match[:separator])

            if match[:year].length == 2
              captures[0] = Date.today.year.to_s.scan(/\d{2}/).first + match[:year]
            end

            captures.collect {|token| Integer(token) }
          end
        end

        def numeral_date_regex
          separator_regex = /(?<separator>#{Regexp.union(VALID_DATE_SEPARATORS)})/
          month_regex = /(?<month>0[1-9]|1[012])/
          day_regex = /(?<day>0[1-9]|\.[1-9]|[12][0-9]|3[01])/
          /#{year_regex}#{separator_regex}?#{month_regex}(\k<separator>)?#{day_regex}/
        end

        private
        # TODO: Possibly clean this up?
        # Given a VALID_YEAR_RANGE of 1998..2002
        def year_regex
          thousandth_ranges = VALID_YEAR_RANGE.inject({}) do |hash, yr|
            thousandth, tenth = yr.to_s.scan(/\d{2}/)
            (hash[thousandth] ||= []) << tenth
            hash
          end # => {'19' => ['98', '99'], '20' => ['00', '01', '02']}

          thousandth_regexes = thousandth_ranges.collect do |y, d|
            "(#{y})?(#{d.join('|')})"
          end # => ["(19)?(98|99)", "(20)?(00|01|02)"]

          /(?<year>(#{thousandth_regexes.join('|')}))/
        end # => /(?<year>((19)?(98|99)|(20)?(00|01|02)))/
      end
    end
  end
end
