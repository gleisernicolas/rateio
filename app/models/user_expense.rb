class UserExpense < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  enum role: { owner: 0, participant: 1 }
end
