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

require 'rails_helper'

RSpec.describe Song, type: :model do
  describe '#validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  describe '#relations' do
    it { should have_many :likes }
    it { should belong_to :user }
    it { should belong_to :performer }
  end
end
