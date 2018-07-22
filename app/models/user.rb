class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  # 設定成 user 與 restaurant 多對多關聯，rails就會知道comments table
  # 扮演了 join table的角色
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 「使用者可以喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # user 之間可以互相追蹤的多對多關聯
  # 一個 user 可以追縱很多人，刪除 user 時一併把追縱紀錄刪除
  has_many :followships, dependent: :destroy
  # 不需再加上 source: :following，因為方法命名與 belongs_to 相同
  has_many :followings, through: :followships

  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :intro
  
  # 每個 User 只能追蹤另一個 User 一次
  # 即特定的 user_id 下，只能有一個 followings_id，搭配 :scope 來限制範圍
  validates :following_id, uniqueness: {scope: :user_id}

end
