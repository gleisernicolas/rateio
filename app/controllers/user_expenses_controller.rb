class UserExpensesController < ApplicationController
  before_action :set_user_expense, only: [:update, :show]
  before_action :authenticate_user!, only: [:show]

  def update
    if params[:user_expense]
      @user_expense.payment_voucher = params[:user_expense][:payment_voucher]
      @user_expense.pending!
    else
      flash[:notice] = 'Por favor inclua uma foto'
    end
    redirect_to expense_path(@user_expense.expense)
  end

  def show; end

  private

  def set_user_expense
    @user_expense = UserExpense.find(params[:id])
  end
end
