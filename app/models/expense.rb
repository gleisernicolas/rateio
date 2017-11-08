class Expense < ApplicationRecord
  validates :title, :description, :event_date, :pay_date, :total_price,
            :participants_amount,
            presence: true

  def pricer_per_participant
    total_price / participants_amount
  end
end
