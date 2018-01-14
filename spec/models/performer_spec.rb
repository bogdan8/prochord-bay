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

require 'rails_helper'

RSpec.describe Performer, type: :model do
  describe '#validations' do
    it { should validate_presence_of :title }
  end

  describe '#relations' do
    it { should have_many :songs }
  end
end
