class Category < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  # 確定新增餐廳分類名稱不會重複現有分類名稱
  
  has_many :restaurants
end
