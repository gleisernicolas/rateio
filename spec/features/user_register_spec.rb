require 'rails_helper'

feature 'user register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar'

    fill_in 'Nome', with: 'Fabricio'
    fill_in 'Email', with: 'fabr_mons@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_css('.alert-info',
                             text: 'Bem-vindo! Você se registrou com êxito.')
  end
end
