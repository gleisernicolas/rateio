require 'rails_helper'

feature 'payment must respect pay date' do
  scenario 'success' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense, pay_date: '10/12/2017')
    expense.user_expenses.create(user: user, role: 1, payment_status: 0)
    expense.user_expenses.create(user: expense_owner, role: 0,
                                 payment_status: 0)

    travel_to Date.parse('12/12/2017') do
      login_as(user, scope: :user)
      visit expense_path expense

      attach_file('Comprovante de pagamento',
                  "#{Rails.root}/spec/support/fixtures/comprovante.png")
      click_on 'Confirmar pagamento'
    end
    save_page
    expect(page).to have_css('.alert-danger', text: 'Pagamento fora do prazo')

    expect(page).to have_css("#status_#{user.id}", text: 'aberto')
  end
end
