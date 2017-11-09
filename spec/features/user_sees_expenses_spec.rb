require 'rails_helper'

feature 'User logs in' do
  scenario 'and sees expenses' do
    expense_1 = create(:expense, title: 'Churrasco para família')
    expense_2 = create(:expense)

    user = create(:user, name: 'Nailson')
    user_expense = create(:user_expense, user: user, expense: expense_1)
    create(:user_expense, expense: expense_2)

    login_as(user)

    visit root_path

    click_on 'Meus Rateios'

    expect(page).to have_css('dt', text: 'Evento')
    expect(page).to have_css('dd', text: expense_1.title)

    expect(page).to have_css('dt', text: 'Descrição')
    expect(page).to have_css('dd', text: expense_1.description)

    expect(page).to have_css('dt', text: 'Data do evento')
    expect(page).to have_css('dd', text: I18n.l(expense_1.event_date))

    expect(page).to have_css('dt', text: 'Data do pagamento')
    expect(page).to have_css('dd', text: I18n.l(expense_1.pay_date))

    expect(page).to have_css('dt', text: 'Valor total')
    expect(page).to have_css('dd', text: 'R$ 200,00')

    expect(page).to have_css('dt', text: 'Número de participantes')
    expect(page).to have_css('dd', text: expense_1.participants_amount)

    expect(page).to have_css('dt', text: 'Valor por participante')
    expect(page).to have_css('dd', text: 'R$ 20,00')

    expect(page).not_to have_css('dd', text: expense_2.title)


  end
end
