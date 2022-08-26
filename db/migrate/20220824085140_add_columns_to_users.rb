class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :job_change_count
      t.string :salary_before_two_years
      t.string :salary_before_one_years
      t.string :current_salary
      t.text :profile
    end
  end
end
