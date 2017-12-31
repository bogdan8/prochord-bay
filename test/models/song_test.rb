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

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
