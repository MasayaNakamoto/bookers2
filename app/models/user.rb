class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

 has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
 has_many :followers, through: :reverse_of_relationships, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人

 has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
 has_many :followings, through: :relationships, source: :followed
  # ここから下↓はもしかしたらいらんかも↓
    def follow(user_id)
      relationships.create(followed_id: user_id)
    end

    def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
    end

    def following?(user)
      followings.include?(user)
    end

# ↓これ多分使わんから消していい
    # ユーザーをフォローする
# def follow(user_id)
#   follower.create(followed_id: user_id)
# end

# # ユーザーのフォローを外す
# def unfollow(user_id)
#   follower.find_by(followed_id: user_id).destroy
# end

# フォローしていればtrueを返す
# def following?(user)
#   followings.include?(user)
# end
 # ここまでいらんやつかも

 def self.search(search)
    if search
      Book.all
    #   User.where('name LIKE(?)', 'introduction LIKE(?)', "%#{search}%")
    #   Book.where('title LIKE(?)', 'body LIKE(?)', "%#{search}%")
    else
      User.all
    end
 end

  attachment :profile_image

  validates :name, presence: true, length: { minimum: 2,  maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end