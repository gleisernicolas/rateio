class UserExpensesController < ApplicationController
  before_action :authenticate_user!, only: [:update, :paid]

  before_action :set_user_expense, only: [:update, :show, :paid]

  def update
    @user_expense.payment_voucher = params[:user_expense][:payment_voucher]
    @user_expense.pending!
    redirect_to expense_path(@user_expense.expense)
  end

  def show; end

  def paid
    redirect_to root_path unless @user_expense.expense.owner?(current_user)
    
    @user_expense.payment_status = :paid
    @user_expense.save
    redirect_to expense_path(@user_expense.expense)
  end

  private

  def set_user_expense
    @user_expense = UserExpense.find(params[:id])
  end
end
