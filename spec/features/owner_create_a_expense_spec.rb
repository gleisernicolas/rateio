require 'rails_helper'

feature 'Owner create a expense' do
  scenario 'successfully' do
    user = create(:user, email: 'teste@teste.com', password: '1q2w30')
    login_as(user)

    visit root_path

    click_on 'Criar Rateio'

    fill_in 'Título', with: 'Futebol'
    fill_in 'Descrição', with: 'Futebol no morumbi'

    select('20', from: 'expense[event_date(3i)]').select_option
    select('Novembro', from: 'expense[event_date(2i)]').select_option
    select('2017', from: 'expense[event_date(1i)]').select_option

    select('18', from: 'expense[pay_date(3i)]').select_option
    select('Novembro', from: 'expense[event_date(2i)]').select_option
    select('2017', from: 'expense[pay_date(1i)]').select_option

    fill_in 'Valor', with: 300
    fill_in 'Participantes', with: 10

    within('div.action') do
      click_on 'Criar Rateio'
    end

    expect(page).to have_css('dt', text: 'Evento')
    expect(page).to have_css('dd', text: 'Futebol')

    expect(page).to have_css('dt', text: 'Descrição')
    expect(page).to have_css('dd', text: 'Futebol no morumbi')

    expect(page).to have_css('dt', text: 'Data do evento')
    expect(page).to have_css('dd', text: '20/11/2017')

    expect(page).to have_css('dt', text: 'Data do pagamento')
    expect(page).to have_css('dd', text: '18/11/2017')

    expect(page).to have_css('dt', text: 'Valor total')
    expect(page).to have_css('dd', text: 'R$ 300,00')

    expect(page).to have_css('dt', text: 'Número de participantes')
    expect(page).to have_css('dd', text: '10')

    expect(page).to have_css('dt', text: 'Valor por participante')
    expect(page).to have_css('dd', text: 'R$ 30,00')

    expect(page).to have_css('dt', text: 'Valor por participante')
    expect(page).to have_css('dd', text: 'R$ 30,00')

    expect(page).to have_css('dt', text: 'Link para convite')
    expect(page).to have_css('dd', text: expense_invite_url(Expense.last.token))
  end

  scenario 'and user is not signed in' do
    visit root_path
    click_on 'Criar Rateio'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and fills nothing' do
    user = create(:user, email: 'teste@teste.com', password: '1q2w30')
    login_as(user)

    visit root_path
    click_on 'Criar Rateio'

    within('div.action') do
      click_on 'Criar Rateio'
    end

    expect(page).to have_css('.alert-danger',
                             text: 'não pode ficar em branco')
  end
end
