class SongCountWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(song)
    song = Song.find(song)
    song.count_views += 1
    song.save
  end
end