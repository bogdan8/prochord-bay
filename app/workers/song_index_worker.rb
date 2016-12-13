class SongIndexWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(song)
    song = Song.find(song)
    song.index!
    UserMailer.send_add_song(song.user, song).deliver_now!
  end
end
