class Song < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :likes, dependent: :destroy
  has_many :song, through: :likes

  searchable do
    text :title.downcase
    text :performer.downcase
    integer :active
    time :created_at
  end

  def self.title_for(title)
    song = where('lower(title) like ? ', "#{title.downcase}_%")
    song.order('created_at desc').limit(10).pluck(:title)
  end

  def self.index_songs
    Song.find_each do |song|
      index_title(song.title)
      song.title.split.each { |t| index_title(t) }
    end
  end

  def self.index_title(title)
    where(title: title.downcase).first_or_initialize.tap do |song|
      song.increment! :popularity
    end
  end
end
