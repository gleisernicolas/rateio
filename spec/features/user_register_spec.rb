require 'rails_helper'

feature 'user register' do
  scenario 'successfully' do
    visit root_path
    within 'nav' do
      click_on 'Cadastrar'
    end

    fill_in 'Nome', with: 'Fabricio'
    fill_in 'Email', with: 'fabr_mons@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    within '.form-actions' do
      click_on 'Cadastrar'
    end

    expect(page).to have_css('.alert-info',
                             text: 'Bem-vindo! Você se registrou com êxito.')
  end

  scenario 'and don\'t fill required fields' do
    visit root_path
    within 'nav' do
      click_on 'Cadastrar'
    end

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    within '.form-actions' do
      click_on 'Cadastrar'
    end

    expect(page).to have_content('não pode ficar em branco')
  end
end
