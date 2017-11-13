require 'rails_helper'

feature 'participant pay expense' do
  scenario 'successfully' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses.create(user: user, role: :participant,
                                                payment_status: :open)
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :open)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus Rateios'
    click_on expense.title

    attach_file('Comprovante de pagamento',
                "#{Rails.root}/spec/support/fixtures/comprovante.png")
    click_on 'Confirmar pagamento'

    expect(current_path).to eq expense_path(expense)
    expect(page).to have_css("#status_#{user.id}", text: 'pendente')
    within "td#receipt_#{user.id}" do
      expect(page).to have_link('Comprovante de pagamento',
                                href: user_expense_path(user_expense))
    end
  end

  scenario 'and sees expense again' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Rodrigo')
    expense = create(:expense)
    expense.user_expenses.create(user: user, role: :participant,
                                 payment_status: :paid)
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(user, scope: :user)
    visit expense_path expense

    expect(page).not_to have_link('Confirmar pagamento')
  end

  scenario 'and sees his voucher' do
    payment_voucher = "#{Rails.root}/spec/support/fixtures/comprovante.png"
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses.create(
      user: user, role: :participant,
      payment_status: :pending,
      payment_voucher: File.new(payment_voucher)
    )
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(user, scope: :user)
    visit expense_path expense
    within "td#receipt_#{user.id}" do
      click_on 'Comprovante de pagamento'
    end

    expect(current_path).to eq user_expense_path(user_expense)
    expect(page).to have_css('h1',
                             text: "Comprovante de pagamento de #{user.name}")
    expect(page).to have_xpath("//img[contains(@src,'payment_voucher')]")
  end

  scenario 'and sees his voucher and returns to expense' do
    payment_voucher = "#{Rails.root}/spec/support/fixtures/comprovante.png"
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses.create(
      user: user, role: :participant, payment_status: :pending,
      payment_voucher: File.new(payment_voucher)
    )
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(user, scope: :user)
    visit expense_path expense
    within "td#receipt_#{user.id}" do
      click_on 'Comprovante de pagamento'
    end

    click_on 'Voltar para o rateio'

    expect(current_path).to eq expense_path(user_expense.expense)
  end

  scenario 'and his voucher do not appear to other participants' do
    payment_voucher = "#{Rails.root}/spec/support/fixtures/comprovante.png"
    user = create(:user, name: 'Christian')
    other_user = create(:user, name: 'João')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses.create(
      user: user, role: :participant, payment_status: :pending,
      payment_voucher: File.new(payment_voucher)
    )
    expense.user_expenses.create(user: other_user, role: :participant,
                                 payment_status: :open)
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(other_user, scope: :user)
    visit expense_path expense

    within "td#receipt_#{user.id}" do
      expect(page).not_to have_link('Comprovante de pagamento',
                                    href: user_expense_path(user_expense))
    end
  end

  scenario 'and expense owner can see all vouchers' do
    payment_voucher = "#{Rails.root}/spec/support/fixtures/comprovante.png"
    user = create(:user, name: 'Christian')
    other_user = create(:user, name: 'João')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses.create(
      user: user, role: :participant, payment_status: :pending,
      payment_voucher: File.new(payment_voucher)
    )
    other_user_expense = expense.user_expenses.create(
      user: other_user, role: :participant, payment_status: :pending,
      payment_voucher: File.new(payment_voucher)
    )
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(expense_owner, scope: :user)
    visit expense_path expense

    within "td#receipt_#{user.id}" do
      expect(page).to have_link('Comprovante de pagamento',
                                href: user_expense_path(user_expense))
    end
    within "td#receipt_#{other_user.id}" do
      expect(page).to have_link('Comprovante de pagamento',
                                href: user_expense_path(other_user_expense))
    end
  end

  scenario 'and open status do not generate voucher link' do
    user = create(:user, name: 'Christian')
    expense_owner = create(:user, name: 'Nicolas')
    expense = create(:expense)
    user_expense = expense.user_expenses
                          .create(user: user, role: :participant,
                                  payment_status: :open)
    expense.user_expenses.create(user: expense_owner, role: :owner,
                                 payment_status: :paid)

    login_as(expense_owner, scope: :user)
    visit expense_path expense

    within "td#receipt_#{user.id}" do
      expect(page).not_to have_link('Comprovante de pagamento',
                                    href: user_expense_path(user_expense))
    end
  end
end
