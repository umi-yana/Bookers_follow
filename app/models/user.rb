class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 has_many :books,dependent: :destroy
  attachment :profile_image
  
  
  # ----フォロー機能アソシエーション---
  
  #自分がフォローされる
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 自分がフォローする
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # 自分をフォローしている人を参照
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  # 自分がフォローしているユーザーを参照
  has_many :followings, through: :relationships, source: :followed



  validates :name,
    presence: true, uniqueness: true, length: { in: 2..20 }
    # 文字数の制限を設ける→length #長さの範囲を2-20文字→in ..
    # 一意性を保つバリデーション（uniqueness: true）
  validates :introduction,
    length: { maximum: 50 }
    # 長さの下限を50文字に設定→minimum
    # presence: trueは、空欄でないことを確認している


end
