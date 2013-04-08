require 'find'
require 'active_support/core_ext/string'

Dir.chdir('/Volumes/NAS/Torrents/Completed/Public')
entries = Find.find(Dir.pwd).collect {|p| p.mb_chars.compose.to_s }
path = '/Users/Gray/projects/wip/renamer/spec/fixtures/files_2.yml'
File.open(path, 'w') {|f| YAML.dump(entries, f, line_width: 999999) }
