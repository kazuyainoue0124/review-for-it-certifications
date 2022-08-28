class Certificate < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :restrict_with_error
  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
