feature 'Participant sees another Participants payment status' do
  scenario 'success' do
    user1 = create(:user, name: 'Nicolas')
    user2 = create(:user, name: 'Fernanda')
    user3 = create(:user, name: 'Antonio')

    expense = create(:expense, title: 'Futebol de domingo')
    expense.user_expenses.create(user: user1, payment_status: :open,
                                 role: :participant)
    expense.user_expenses.create(user: user2, payment_status: :open,
                                 role: :owner)
    expense.user_expenses.create(user: user3, payment_status: :open,
                                 role: :participant)

    login_as(user1)
    visit expense_path(expense)

    expect(page).to have_css('td', text: user2.name)
    expect(page).to have_css('td', text: user3.name)

  end
end
