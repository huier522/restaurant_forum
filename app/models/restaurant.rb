class Restaurant < ApplicationRecord
  validates_presence_of :name

  mount_uploader :image, PhotoUploader

  belongs_to :category

  # 加上 dependent: :destroy
  # 刪除 Restaurant 時，就可以一併刪掉關聯的評論
  has_many :comments, dependent: :destroy

  # 餐廳擁有很多收藏者
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
end
