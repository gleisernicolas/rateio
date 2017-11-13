class UserExpense < ApplicationRecord
  enum role: { owner: 0, participant: 1 }
  enum payment_status: { open: 0, paid: 1, pending: 2 }
  belongs_to :user
  belongs_to :expense
  has_attached_file :payment_voucher
  validates_attachment_content_type :payment_voucher,
                                    content_type: %r{\Aimage\/.*\z}
end
