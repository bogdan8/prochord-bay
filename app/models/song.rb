class Song < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :likes
  has_many :song, through: :likes
end
