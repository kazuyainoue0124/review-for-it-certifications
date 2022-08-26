class AddIndexToCertificatesName < ActiveRecord::Migration[6.1]
  def change
    add_index :certificates, :name, unique: true
  end
end
