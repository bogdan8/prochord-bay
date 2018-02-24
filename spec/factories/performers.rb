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

FactoryBot.define do
  factory :performer do
    title { Faker::Lorem.characters(10) }
    slug { Faker::Lorem.characters(10) }
    avatar { Faker::Avatar.image }
  end
end
