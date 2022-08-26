class User < ApplicationRecord
  belongs_to :position, optional: true
  belongs_to :certificate, optional: true
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
end
