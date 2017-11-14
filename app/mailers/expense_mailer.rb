class ExpenseMailer < ApplicationMailer
  def payment_received(user_expense_id)
    user_expense = UserExpense.find(user_expense_id)
    @user = user_expense.user
    @expense = user_expense.expense
    subject = "#{@user.name} mandou um comprovante de pagamento para \
#{@expense.title}"
    mail(to: @expense.owner.email, subject: subject)
  end
end
