class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates do |t|
      t.string :name

      t.timestamps
    end
  end
end
