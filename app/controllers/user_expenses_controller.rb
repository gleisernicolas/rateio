class UserExpensesController < ApplicationController
  def update
    user_expense = UserExpense.find(params[:id])
    user_expense.payment_voucher = params[:user_expense][:payment_voucher]
    user_expense.pending!
    redirect_to expense_path(user_expense.expense)
  end
end
