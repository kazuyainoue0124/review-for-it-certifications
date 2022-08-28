class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :study_period
      t.text :how_to_study
      t.integer :valuable_scoree
      t.text :how_change
      t.integer :recommend_score
      t.text :recommended_person
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :certificate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
