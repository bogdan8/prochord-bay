namespace :db do
  desc 'Generate search title from song'
  task songs_index: :environment do
    Song.index_songs
  end
end