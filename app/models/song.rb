class Song < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :likes
  has_many :song, through: :likes

  def self.active
    where(active: 1)
  end

  def self.title_for(title)
    song = where('title like ? ', "#{title}_%")
    song.order('created_at desc').limit(10).pluck(:title)
  end

  def self.index_songs
    Song.find_each do |song|
      index_title(song.title)
      song.title.split.each { |t|  index_title(t)}
    end
  end

  def self.index_title(title)
    where(title: title.downcase).first_or_initialize.tap do |title|
      title.increment! :popularity
    end
  end

end
