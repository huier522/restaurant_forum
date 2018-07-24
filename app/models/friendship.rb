class Friendship < ApplicationRecord
  # 每一筆好友記錄，屬於發出交友的使用者(user)
  belongs_to :user
  # 每一筆好友記錄，屬於被加好友的使用者(friending)
  belongs_to :friend, class_name: "User"
end
