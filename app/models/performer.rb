# == Schema Information
#
# Table name: performers
#
#  id                  :integer          not null, primary key
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  slug                :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Performer < ApplicationRecord
  DEFAULT_URL = '/images/:style/missing.png'.freeze
  PATH = ':rails_root/public/images/:class/:attachment/:id/:style/:filename'.freeze
  URL = '/images/:class/:attachment/:id/:style/:filename'.freeze
  extend FriendlyId
  include Paperclip::Glue

  has_many :songs, dependent: :destroy

  has_attached_file :avatar, styles: { thumb: '100x100>' }, default_url: DEFAULT_URL, path: PATH, url: URL
  validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :title, presence: true

  friendly_id :title, use: [:slugged]

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
