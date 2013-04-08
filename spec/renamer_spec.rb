require 'spec_helper'

describe Renamer::VideoScanner do

  before(:all) do
    seed_fs(load_fixture('files_2.yml'))
    @scanner = Renamer::VideoScanner.new(tmp_dir)
  end

  describe '#video_files' do

    it 'should be a array' do
      @scanner.video_files.should be_kind_of(Array)
    end
  end
end
