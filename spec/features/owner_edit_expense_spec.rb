require 'rails_helper'

feature 'owner edit expense' do
  scenario 'sucessfully' do
    user = create(:user)
    login_as(user, scope: :user)

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
    click_on 'Editar'

    fill_in 'Título', with: 'Aluguel'
    click_on 'Atualizar Rateio'
    expect(page).to have_css('dt', text: 'Evento')
    expect(page).to have_css('dd', text: 'Aluguel')
  end
end
