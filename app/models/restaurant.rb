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

  # 餐廳可以被很多使用者喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 檢查收藏紀錄是否存在
  # 當你手上有一個 Restaurant 物件，以及一個 User 物件時，就可以在 favorites table 上查詢
  # 看看是否有一筆資料，其外鍵 restaurant_id 和 user_id 都符合條件。
  def is_favorited?(user)
    # 使用關聯方法 self.favorited_users 查出該餐廳物件相關的所有 User 紀錄。
    #  include?(user) 方法，查看這一堆 User 紀錄中，是否包含我們指定的 User 物件。
    self.favorited_users.include?(user)
  end
end
