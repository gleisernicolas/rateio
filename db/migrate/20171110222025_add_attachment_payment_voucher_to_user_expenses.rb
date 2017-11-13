class AddAttachmentPaymentVoucherToUserExpenses < ActiveRecord::Migration[5.1]
  def self.up
    change_table :user_expenses do |t|
      t.attachment :payment_voucher
    end
  end

  def self.down
    remove_attachment :user_expenses, :payment_voucher
  end
end
