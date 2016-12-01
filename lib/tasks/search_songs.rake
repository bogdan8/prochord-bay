namespace :search_songs do
  desc "Generate search title from song"
  task index: :environment do
    Song.index_songs
  end
end