require File.expand_path('../../lib/renamer', __FILE__)
Bundler.require(:test)

module Helpers
  def path_to_fixture(name)
    File.join(File.dirname(__FILE__), 'fixtures', name)
  end

  def load_fixture(name)
    YAML.load_file(path_to_fixture(name))
  end

  def tmp_dir
    @tmp_dir ||= Dir.mktmpdir
  end

  def seed_fs(paths)
    paths.each do |path|
      if Renamer::FileTools.video_file?(path)
        path = File.join(tmp_dir, path)
        FileUtils.mkpath(File.dirname(path))
        FileUtils.touch(path) unless File.exist?(path)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers

  config.after(:all) do
    FileUtils.rm_rf(tmp_dir)
  end
end
