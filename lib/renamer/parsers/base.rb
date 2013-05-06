module Renamer
  module Parsers
    module Base
      class UnparseableDate < StandardError
        def initialize(input, parser, exception)
          super("#{parser} is unable to parse #{input}: #{exception}")
          set_backtrace(exception.backtrace)
        end
      end

      attr_reader :input

      def initialize(input)
        @input = input
      end

      def result
        @result ||= parse || handle_exception
      end

      def parse
        input # noop
      rescue => exception
        handle_exception(exception)
      end

      private
      def handle_exception(exception = nil)
        raise UnparseableDate.new(input.inspect, self.class.name, exception)
      end
    end
  end
end
