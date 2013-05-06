require 'spec_helper'
require 'renamer/parsers/dates/hangul_parser'

describe Renamer::Parsers::Dates::HangulParser do

  let(:parser) { Renamer::Parsers::Dates::HangulParser.new('[이천십이년.오월.이십일] 소녀시대-태티서 twinkle 인기가요.tp') }

  describe '#parse' do

    it 'returns date object from a hangul string' do
      parser.parse.should eql(Date.parse('120520'))
    end
  end
end
