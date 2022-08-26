class AddIndexToPositionsName < ActiveRecord::Migration[6.1]
  def change
    add_index :positions, :name, unique: true
  end
end
