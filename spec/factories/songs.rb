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

FactoryBot.define do
  factory :song do
    title { Faker::Lorem.word }
    slug { Faker::Lorem.word }
    body { Faker::Lorem.paragraphs }
    active 1
    avatar { Faker::Avatar.image }
  end
end
