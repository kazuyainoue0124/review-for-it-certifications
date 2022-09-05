class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships, bulk: true do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps

      t.index :follower_id
      t.index :followed_id
      t.index %i[follower_id followed_id], unique: true
    end
  end
end
