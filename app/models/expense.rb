class Expense < ApplicationRecord
  validates :title, :description, :event_date, :pay_date, :total_price,
            :participants_amount,
            presence: true

  has_many :user_expenses
  has_many :users, through: :user_expenses
  has_secure_token

  has_attached_file :event_photo
  validates_attachment_content_type :event_photo,
                                    content_type: %r{\Aimage\/.*\z}

  def pricer_per_participant
    total_price / participants_amount
  end

  def owner
    user_expense = user_expenses.find_by(role: :owner)
    user_expense.user if user_expense
  end

  def owner?(user)
    owner == user
  end
end
