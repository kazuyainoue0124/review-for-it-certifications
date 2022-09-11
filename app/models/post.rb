class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :certificate, optional: true
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :certificate_id, presence: true
  validates :study_period, presence: true
  validates :valuable_score, presence: true
  validates :recommend_score, presence: true

  # 記事検索
  def self.search(word)
    @post = Post.where('title LIKE?', "%#{word}%")
  end

  # ブックマーク済かチェック
  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  # いいね！済かチェック
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
