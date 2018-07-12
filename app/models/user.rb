class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  
  has_many :comments
  
  def admin?
    self.role == "admin"
  end

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :intro

end
