# == Schema Information
#
# Table name: users_roles
#
#  user_id :integer
#  role_id :integer
#

class UsersRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
end
