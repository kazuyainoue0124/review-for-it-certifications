class AddReferencesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :certificate, foreign_key: true
    add_reference :users, :position, foreign_key: true
  end
end
