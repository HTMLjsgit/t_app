class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

 validates :username, uniqueness: { case_sensitive: :false }, length: { minimum: 1, maximum: 20 }

 has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
 has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得

 has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
 has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

 has_many :user_rooms # 参加部屋情報のリレーションテーブル
 has_many :rooms, through: :user_rooms # 部屋テーブル

 has_many :payments, dependent: :destroy #決済したもの すべて取得
 has_many :posts, dependent: :destroy # 投稿
 has_many :comments, dependent: :destroy#コメント
 has_many :real_comments, dependent: :destroy #コメント
 has_many :reals, dependent: :destroy #リアル
 has_many :likes, dependent: :destroy #いいね
 has_many :real_likes, dependent: :destroy
 has_many :sales, dependent: :destroy
 has_one :transfer_request, dependent: :destroy
 after_create_commit :on_create
 mount_uploader :background_image, ImageUploader
 mount_uploader :avater, ImageUploader
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

  def nofollow?(user)
    following_user.exclude?(user)
  end

  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    to_adapter.find_first(warden_conditions)
  end

  def on_create
    TransferRequest.create!(user_id: self.id, transfer_mode: false)
  end
end
