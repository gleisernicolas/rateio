class ExpensesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create,
                                            :invite, :accept_invite]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      flash[:notice] = 'Rateio cadastrado com sucesso!'
      redirect_to expense_url @expense
    else
      render :new
    end
  end

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

  def index
    @expenses = current_user.expenses
    if @expenses.empty?
      flash[:alert] = 'Nenhum rateio cadastrado'
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :event_date, :pay_date,:total_price,
                                    :description, :participants_amount)
  end
end
