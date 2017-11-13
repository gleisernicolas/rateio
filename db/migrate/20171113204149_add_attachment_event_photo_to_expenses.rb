class AddAttachmentEventPhotoToExpenses < ActiveRecord::Migration[5.1]
  def self.up
    change_table :expenses do |t|
      t.attachment :event_photo
    end
  end

  def self.down
    remove_attachment :expenses, :event_photo
  end
end
