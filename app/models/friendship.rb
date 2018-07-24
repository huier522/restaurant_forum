class Friendship < ApplicationRecord

  # 每個 user 都只能跟另一個 user 加一次好友 
  validates :friend_id, uniqueness: { scope: :user_id }

  # 每一筆好友記錄，屬於發出交友的使用者(user)
  belongs_to :user
  # 每一筆好友記錄，屬於被加好友的使用者(friending)
  belongs_to :friend, class_name: "User"
  
end
