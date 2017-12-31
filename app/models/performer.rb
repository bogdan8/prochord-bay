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
  extend FriendlyId
  include Paperclip::Glue

  has_many :songs, dependent: :destroy

  has_attached_file :avatar, styles: {thumb: '100x100>'},
                    default_url: '/images/:style/missing.png',
                    path: ':rails_root/public/images/:class/:attachment/:id/:style/:filename',
                    url: '/images/:class/:attachment/:id/:style/:filename'
  validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :title, presence: true


  searchable do
    text :title.downcase, stored: true
    text :songs do
      songs.map { |song| song.title }
    end
    time :created_at
  end

  friendly_id :title, use: [:slugged]

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
