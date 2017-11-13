class UserExpensesController < ApplicationController
  before_action :set_user_expense, only: [:voucher, :show]
  before_action :authenticate_user!, only: [:show]

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

  private

  def set_user_expense
    @user_expense = UserExpense.find(params[:id])
  end

  def voucher_params
    params.require(:user_expense).permit(:payment_voucher)
  end
end
