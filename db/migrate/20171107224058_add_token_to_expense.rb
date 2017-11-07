class AddTokenToExpense < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :token, :string
  end
end
