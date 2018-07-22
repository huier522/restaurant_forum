class Followship < ApplicationRecord
  # 每個 User 只能追蹤另一個 User 一次
  # 即特定的 user_id 下，只能有一個 followings_id，搭配 :scope 來限制範圍
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User"
end
