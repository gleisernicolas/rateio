class ExpensesController < ApplicationController
  before_action :authenticate_user!, only: %i[new , create]

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

  def show
    @expense = Expense.find(params[:id])
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :event_date, :pay_date,
                                    :total_price, :description,
                                    :participants_amount)
  end
end
