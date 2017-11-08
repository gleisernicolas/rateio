class ChangeCollumnNameFromTableExpense < ActiveRecord::Migration[5.1]
  def change
    rename_column :expenses, :participants_amout, :participants_amount
  end
end
