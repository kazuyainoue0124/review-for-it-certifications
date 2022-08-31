class ChangeDataRecommendScoreToPost < ActiveRecord::Migration[6.1]
  def up
    change_column :posts, :recommend_score, :string
  end
end
