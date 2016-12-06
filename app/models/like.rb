class Like < ApplicationRecord
  belongs_to :user
  belongs_to :song, counter_cache: true
end
