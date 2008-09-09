class CreatePlaylists < ActiveRecord::Migration
    def self.up
          create_table :icy_tracks do |t|                                                                               
              t.string  :title                                                                                                                                                            
              t.string  :artist        
          end
        
          create_table :icy_playlists do |t|
              t.integer :track_id
              t.timestamp :played_at
              t.integer :dj_id
          end
    end
          
    def self.down
        drop_table :icy_tracks
        drop_table :icy_playlists
    end
end