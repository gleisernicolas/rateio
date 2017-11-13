class UserExpensesController < ApplicationController
  before_action :authenticate_user!, only: [:update, :paid, :show]

  before_action :set_user_expense, only: [:update, :show, :paid, :voucher]

  def voucher
    @user_expense.update(voucher_params)
    flash[:notice] = if @user_expense.mark_as_pending
                       t('user_expense.voucher.success')
                     else
                       t('user_expense.voucher.error')
                     end
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

  def voucher_params
    params.require(:user_expense).permit(:payment_voucher)
  end
end
