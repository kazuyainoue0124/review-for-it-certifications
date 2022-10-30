class Certificate < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :restrict_with_error
  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  def self.create_certificate_ranks
    Certificate.find(User.group(:certificate_id).order('count(certificate_id) desc').limit(10).pluck(:certificate_id)) if Certificate.count != 0
  end
end
