require 'rails_helper'

feature 'participant logs in' do
  scenario 'and sees expenses' do
    expense1 = create(:expense, title: 'Churrasco para família')
    expense2 = create(:expense)

    user = create(:user, name: 'Nailson')
    another_user = create(:user)
    create(:user_expense, user: user, expense: expense1, role: :owner)
    create(:user_expense, user: another_user, expense: expense2, role: :owner)

    login_as(user)

    visit root_path

    click_on 'Meus Rateios'

    expect(page).to have_css('dt', text: 'Evento')
    expect(page).to have_css('dd', text: expense1.title)

    expect(page).to have_css('dt', text: 'Descrição')
    expect(page).to have_css('dd', text: expense1.description)

    expect(page).to have_css('dt', text: 'Data do evento')
    expect(page).to have_css('dd', text: I18n.l(expense1.event_date))

    expect(page).to have_css('dt', text: 'Data do pagamento')
    expect(page).to have_css('dd', text: I18n.l(expense1.pay_date))

    expect(page).to have_css('dt', text: 'Valor total')
    expect(page).to have_css('dd', text: 'R$ 200,00')

    expect(page).to have_css('dt', text: 'Número de participantes')
    expect(page).to have_css('dd', text: expense1.participants_amount)

    expect(page).to have_css('dt', text: 'Valor por participante')
    expect(page).to have_css('dd', text: 'R$ 20,00')

    expect(page).not_to have_css('dd', text: expense2.title)
    expect(page).not_to have_css('button', text: 'Apagar rateio')
    expect(page).not_to have_css('.alert-danger',
                                 text: 'Nenhum rateio cadastrado')
  end

  scenario 'and have no expense registred' do
    expense1 = create(:expense, title: 'Churrasco para família')
    expense2 = create(:expense)
    create(:user_expense, expense: expense1)
    create(:user_expense, expense: expense2)

    user = create(:user, name: 'Nailson', email: 'email@email.com',
                         password: 'senhauser123')

    visit root_path
    within('nav') do
      click_on 'Entrar'
      
    end

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: 'senhauser123'

    within('div.form-actions') do
      click_on 'Entrar'
    end

    click_on 'Meus Rateios'

    expect(page).to have_css('.alert-danger', text: 'Nenhum rateio cadastrado')

    expect(page).not_to have_css('dd', text: expense1.title)
    expect(page).not_to have_css('dd', text: expense2.title)
  end
end
