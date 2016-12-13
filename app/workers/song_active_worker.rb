class SongActiveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(song)
    song = Song.find(song)
    song.update(active: 1)
    song.index!
    UserMailer.send_add_song_active(song.user, song).deliver_now!
  end
end