require 'rails_helper'

feature 'participant pay expense' do
  scenario 'successfully' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    expense.user_expenses.create(user: user, role: 1, payment_status: 0)
    expense.user_expenses.create(user: expense_owner, role: 0,
                                 payment_status: 0)

    login_as(user, scope: :user)
    visit expense_path expense
    click_on 'Confirmar pagamento'

    expect(current_path).to eq expense_path(expense)
    expect(page).to have_css("#status_#{user.id}", text: 'pago')
  end

  scenario 'and sees expense again' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    expense.user_expenses.create(user: user, role: 1, payment_status: 1)
    expense.user_expenses.create(user: expense_owner, role: 0,
                                 payment_status: 0)

    login_as(user, scope: :user)
    visit expense_path expense

    expect(page).not_to have_link('Confirmar pagamento',
                                  href: pay_expense_path(expense))
  end
end
