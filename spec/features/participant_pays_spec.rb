require 'rails_helper'

feature 'participant pay expense' do
  scenario 'successfully' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    expense.user_expenses.create(user: user, role: 0, payment_status: 0)
    expense.user_expenses.create(user: expense_owner, role: 1, payment_status: 0)

    login_as(user, scope: :user)
    visit expense_path expense
    click_on 'Confirmar pagamento'

    expect(current_path).to eq expense_path(expense)
    expect(page).to have_css("#status_#{user.id}", text: 'pago')
  end
end
