class RenameValuableScoreeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :valuable_scoree, :valuable_score
  end
end
