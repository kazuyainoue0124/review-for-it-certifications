class ChangeDataValuableScoreToPost < ActiveRecord::Migration[6.1]
  def up
    change_column :posts, :valuable_score, :string
  end
end
