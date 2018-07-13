class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 設定成 user 與 restaurant 多對多關聯，rails就會知道comments table
  # 扮演了 join table的角色
  has_many :comments
  has_many :restaurants, through: :comments

  
  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :intro

end
