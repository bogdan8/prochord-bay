# == Schema Information
#
# Table name: songs
#
#  id                  :integer          not null, primary key
#  title               :string
#  body                :text
#  count_views         :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :integer          default(0)
#  likes_count         :integer          default(0)
#  slug                :string
#  user_id             :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  performer_id        :integer
#

class Song < ApplicationRecord
  extend FriendlyId
  include Paperclip::Glue

  has_many :likes, dependent: :destroy
  has_many :song, through: :likes, inverse_of: :songs
  belongs_to :user
  belongs_to :performer

  has_attached_file :avatar, styles: { thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :title, presence: true
  validates :body, presence: true

  searchable do
    text :title.downcase, stored: true
    text :performer do
      performer.title
    end
    integer :active
    time :created_at
  end

  friendly_id :title, use: [:slugged]

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
