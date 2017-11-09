class AddPaymentStatusToUserExpense < ActiveRecord::Migration[5.1]
  def change
    add_column :user_expenses, :payment_status, :integer
  end
end
