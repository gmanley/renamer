require 'spec_helper'
require 'renamer/parsers/dates/numeral_parser'

describe Renamer::Parsers::Dates::NumeralParser do

  let(:parser) { Renamer::Parsers::Dates::NumeralParser.new('120515 Mnet Japan MCD BS - TTS [GBSHD].ts') }

  describe '#parse' do

    it 'returns date object from string' do
      parser.parse.should eql(Date.parse('120515'))
    end
  end
end
