class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.text :description
      t.date :event_date
      t.date :pay_date
      t.decimal :total_price
      t.integer :participants_amout

      t.timestamps
    end
  end
end
