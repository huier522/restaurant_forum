class Category < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  # 確定新增餐廳分類名稱不會重複現有分類名稱
  
  # 如果分類下已有餐廳，就不允許刪除分類（刪除時拋出 Error）
  has_many :restaurants, dependent: :restrict_with_error
end
