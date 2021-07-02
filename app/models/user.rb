class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :xxx, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :xxx, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # ここから下↓はもしかしたらいらんかも↓
    # def follow(user_id)
    #   relationships.create(followed_id: user_id)
    # end

    # def unfollow(user_id)
    #   relationships.find_by(followed_id: user_id).destroy
    # end

    # def following?(user)
    #   followings.include?(user)
    # end

    # ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end

    # ここまでいらんやつかも

  attachment :profile_image

  validates :name, presence: true, length: { minimum: 2,  maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end