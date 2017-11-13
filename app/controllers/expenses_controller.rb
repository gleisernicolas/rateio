class ExpensesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :invite,
                                            :accept_invite]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save

      @expense.user_expenses.create(user: current_user, payment_status: :open,
                                    role: :owner)

      flash[:notice] = 'Rateio cadastrado com sucesso!'
      redirect_to expense_path @expense
    else
      render :new
    end
  end

  def invite
    @expense = Expense.find_by(token: params[:token])
    if UserExpense.find_by(user: current_user, expense: @expense)
      flash[:notice] = 'Você já está nesse rateio'
      redirect_to @expense
    else
      render :invite
    end
  end

  def accept_invite
    @expense = Expense.find_by(token: params[:token])
    @expense.user_expenses.create(user: current_user, payment_status: :open,
                                  role: :participant)
    redirect_to @expense
  end

  def show
    @expense = Expense.find(params[:id])
    @user_expenses = @expense.user_expenses
    @current_user_expense = current_user.user_expenses.find_by(
      expense: @expense
    )
  end

  def index
    @expenses = current_user.expenses
    flash[:alert] = 'Nenhum rateio cadastrado' if @expenses.empty?
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      flash[:notice] = 'Rateio atualizado com sucesso!'
      redirect_to expense_url @expense
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :event_date, :pay_date,
                                    :total_price, :event_photo,
                                    :description, :participants_amount)
  end
end
