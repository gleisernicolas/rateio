class CreateUserExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_expenses do |t|
      t.references :user, foreign_key: true
      t.references :expense, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
