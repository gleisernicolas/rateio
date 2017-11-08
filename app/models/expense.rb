class Expense < ApplicationRecord
  has_many :user_expenses
  has_many :users, through: :user_expenses
  has_secure_token
end
