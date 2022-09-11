class User < ApplicationRecord
  belongs_to :position, optional: true
  belongs_to :certificate, optional: true
  has_many :posts, dependent: :restrict_with_error
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  # フォローする、される
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: 'followed'
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # メールアドレスの大文字と小文字を区別しない
  before_save { self.email = email.downcase }
  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 15 }
  # メールアドレスのバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # Userモデルにpassword_digest属性を追加
  has_secure_password
  # パスワードのバリデーションチェック
  validates :password, presence: true, length: { minimum: 6, maximum: 10 }, allow_nil: true

  # ユーザー検索
  def self.search(word)
    @user = User.where('profile LIKE?', "%#{word}%")
  end

  # フォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
