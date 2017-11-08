require 'rails_helper'

feature 'owner adds participants to expense' do
  scenario 'sucessfully' do
    user = create(:user)
    expense = create(:expense, title: 'Futebol de domingo')

    login_as(user, scope: :user)
    visit "/convites/#{expense.token}"
    click_on 'Aceitar convite'

    expect(page).to have_css('h1', text: 'Futebol de domingo')
    expect(page).to have_css('h2', text: 'Participantes')
    expect(page).to have_css('li', text: user.name)
  end

  scenario 'and participants is not registered' do
    expense = create(:expense, title: 'Futebol de domingo')

    visit "/convites/#{expense.token}"

    expect(current_path).to eq(new_user_session_path)
  end
end
