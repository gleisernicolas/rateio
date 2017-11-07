class ExpensesController < ApplicationController
  def invite
    @expense = Expense.find_by(token: params[:token])
  end

  def accept_invite
    @expense = Expense.find_by(token: params[:token])
    @expense.users << current_user
    @expense.save
    redirect_to @expense
  end

  def show
    @expense = Expense.find(params[:id])
  end
end
