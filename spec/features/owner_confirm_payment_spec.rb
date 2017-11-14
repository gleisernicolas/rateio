require 'rails_helper'

feature 'owner confirm user payment' do
  scenario 'sucessfully' do
    owner = create(:user, name: 'Nailson')
    user = create(:user, name: 'João')
    expense = create(:expense, title: 'Pizza')
    expense.user_expenses.create(user: owner, payment_status: :open,
                                 role: :owner)
    participant_expense = expense.user_expenses.create(user: user,
                                                       payment_status: :open,
                                                       role: :participant)

    login_as(owner, scope: :user)
    visit root_path
    click_on 'Meus Rateios'
    click_on expense.title

    within "td#action_expense_#{participant_expense.id}" do
      click_on 'Confirmar'
    end

    expect(current_path).to eq expense_path(expense)
    expect(page).to have_css("#status_#{user.id}", text: 'pago')
  end

  scenario 'and the status are pending' do
    owner = create(:user, name: 'Nailson')
    user = create(:user, name: 'João')
    expense = create(:expense, title: 'Pizza')
    expense.user_expenses.create(user: owner, payment_status: :pending,
                                 role: :owner)
    participant_expense = expense.user_expenses.create(user: user,
                                                       payment_status: :pending,
                                                       role: :participant)

    login_as(owner, scope: :user)
    visit expense_path(expense)

    within "td#action_expense_#{participant_expense.id}" do
      click_on 'Confirmar'
    end

    expect(page).to have_css("#status_#{user.id}", text: 'pago')
  end

  scenario 'and the status are paid' do
    owner = create(:user, name: 'Nailson')
    user = create(:user, name: 'João')
    expense = create(:expense, title: 'Pizza')
    expense.user_expenses.create(user: owner, payment_status: :paid,
                                 role: :owner)
    participant_expense = expense.user_expenses.create(user: user,
                                                       payment_status: :paid,
                                                       role: :participant)

    login_as(owner, scope: :user)
    visit expense_path(expense)

    within "td#action_expense_#{participant_expense.id}" do
      expect(page).not_to have_css('a', text: 'Confirmar')
    end
  end
end
