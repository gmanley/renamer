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

require 'renamer/file_tools'
require 'renamer/video_scanner'

module Renamer
  VIDEO_EXTENSIONS = %w[.3gp .asf .asx .avi .flv .iso .m2t .m2ts .m2v .m4v .mkv
                        .mov .mp4 .mpeg .mpg .mts .ts .tp .trp .vob .wmv .swf]

  year = /(?<year>(20)?(07|08|09|10|11|12|13))/
  month = /(?<month>0[1-9]|1[012])/
  day = /(?<day>0[1-9]|\.[1-9]|[12][0-9]|3[01])/
  NUMERAL_DATE_REGEX = /#{year}(?<separator>\.|\-|\/|_)?#{month}(\k<separator>)?#{day}/

  HANGUL_DATE_REGEX = /\[(\p{Hangul}+)\.(\p{Hangul}+)\.(\p{Hangul}+)\]/
  HANGUL_DATE_TO_NUMERAL = YAML.load_file(File.expand_path('../renamer/data/hangul_dates.yml', __FILE__))
  EVENT_NAMES = YAML.load_file(File.expand_path('../renamer/data/events.yml', __FILE__))

  NUMERAL_DATE_FORMAT = '[%y.%m.%d]'
end
