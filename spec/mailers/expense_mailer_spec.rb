require 'rails_helper'

RSpec.describe ExpenseMailer, type: :mailer do
  describe 'receive notification' do
    it 'renders email successfully' do
      user = create(:user, name: 'Christian')
      expense_owner = create(:user, name: 'Nicolas')
      expense = create(:expense)
      user_expense = expense.user_expenses.create(
        user: user, role: :participant, payment_status: :open
      )
      expense.user_expenses.create(
        user: expense_owner, role: :owner, payment_status: :open
      )

      mail = ExpenseMailer.payment_received(user_expense.id)

      expect(mail.to).to include expense_owner.email
      expect(mail.from).to include 'no-reply@rateio.com'
      expect(mail.subject).to eq "#{user.name} mandou um comprovante de \
pagamento para #{expense.title}"
    end

    it 'renders email body successfully' do
      user = create(:user, name: 'Christian')
      expense_owner = create(:user, name: 'Nicolas')
      expense = create(:expense)
      user_expense = expense.user_expenses.create(
        user: user, role: :participant, payment_status: :open
      )
      expense.user_expenses.create(
        user: expense_owner, role: :owner, payment_status: :open
      )

      mail = ExpenseMailer.payment_received(user_expense.id)

      link = "<a href=\"#{expense_url(expense)}\">#{expense.title}</a>"
      p1 = "Você recebeu com comprovante de pagamento de #{user.name}."
      p2 = "Veja esse comprovante e outros em #{link}"

      expect(mail.body).to match('Comprovante de pagamento recebido')
      expect(mail.body).to match p1
      expect(mail.body).to match p2
    end
  end
end
