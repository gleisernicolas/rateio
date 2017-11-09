class Expense < ApplicationRecord
  validates :title, :description, :event_date, :pay_date, :total_price,
            :participants_amount,
            presence: true

  has_many :user_expenses
  has_many :users, through: :user_expenses
  has_secure_token

  def pricer_per_participant
    total_price / participants_amount
  end

  def owner?(user)
    owner = user_expenses.find_by(role: 0)
    user == owner
  end
end
