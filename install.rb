require 'fileutils'

icy_config = File.dirname(__FILE__) + '/../../../config/icy.yml'
FileUtils.cp File.dirname(__FILE__) + '/icy.yml.tpl', icy_config unless File.exist?(icy_config)

icy_playlist = File.dirname(__FILE__) + '/../../../app/models/icy_playlist.rb'
FileUtils.cp File.dirname(__FILE__) + '/lib/icy_playlist.rb', icy_playlist unless File.exist?(icy_playlist)

icy_track = File.dirname(__FILE__) + '/../../../app/models/icy_track.rb'
FileUtils.cp File.dirname(__FILE__) + '/lib/icy_track.rb', icy_track unless File.exist?(icy_track)

start_icy_ruby = File.dirname(__FILE__) + '/../../../script/start_icy_ruby.rb'
FileUtils.cp File.dirname(__FILE__) + '/script/start_icy_ruby.rb', start_icy_ruby unless File.exist?(start_icy_ruby)


migration = File.dirname(__FILE__) + '/../../../db/migrate/001_create_playlists.rb'
FileUtils.cp File.dirname(__FILE__) + '/db/migrate/001_create_playlists.rb', migration unless File.exist?(migration)

puts IO.read(File.join(File.dirname(__FILE__), 'README'))