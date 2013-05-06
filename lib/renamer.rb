# encoding: UTF-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

# TODO: Remove bundler and convert to gemspec
require 'bundler/setup'
Bundler.require(:default)

require 'date'
require 'fileutils'
require 'find'
require 'pathname'
require 'yaml'
require 'logger'

require 'renamer/file_tools'
require 'renamer/video_scanner'

module Renamer
  DATA_ROOT = File.expand_path('../renamer/data', __FILE__)

  VALID_EXTENSIONS = %w[.3gp .asf .asx .avi .flv .iso .m2t .m2ts .m2v .m4v .mkv
                        .mov .mp4 .mpeg .mpg .mts .ts .tp .trp .vob .wmv .swf]

  NUMERAL_DATE_FORMAT = '[%y.%m.%d]'

  def self.logger
    @logger ||= begin
      logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
      logger
    end
  end
end
