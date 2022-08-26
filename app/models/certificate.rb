class Certificate < ApplicationRecord
  has_many :users, dependent: :destroy
  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
