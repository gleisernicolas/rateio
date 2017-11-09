class UserExpense < ApplicationRecord
  enum role: { owner: 0, participant: 1 }
  enum payment_status: { open: 0, paid: 1}
  belongs_to :user
  belongs_to :expense
end
