require 'renamer/parsers/base'

module Renamer
  module Parsers
    module EventsParser
      include Base

      EVENT_NAMES = YAML.load_file(File.join(DATA_ROOT, 'events.yml'))

      def parse
        EVENT_NAMES.find do |normalized_event, possible_events|
          possible_events.find { |possible_event| input.include?(possible_event) }
        end.first
      end
    end
  end
end
