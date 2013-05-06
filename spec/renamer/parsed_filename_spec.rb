# require 'spec_helper'

# describe Renamer::ParsedFilename do

#   describe '#parse_numeral_date' do

#     let(:parser) { Renamer::ParsedFilename.new('120515 Mnet Japan MCD BS - TTS [GBSHD].ts') }

#     it 'returns numeral date from filename' do
#       parser.parse_numeral_date.should eql('[12.05.15]')
#     end

#     it 'adds replaced text as key and parsed date to replacements hash' do
#       parser.parse_numeral_date
#       parser.replacements['120515'].should eql('[12.05.15]')
#     end
#   end
# end
