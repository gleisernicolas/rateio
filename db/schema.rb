# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171113204149) do

  create_table "expenses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "event_date"
    t.date "pay_date"
    t.decimal "total_price"
    t.integer "participants_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "event_photo_file_name"
    t.string "event_photo_content_type"
    t.integer "event_photo_file_size"
    t.datetime "event_photo_updated_at"
  end

  create_table "user_expenses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "expense_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_status"
    t.string "payment_voucher_file_name"
    t.string "payment_voucher_content_type"
    t.integer "payment_voucher_file_size"
    t.datetime "payment_voucher_updated_at"
    t.index ["expense_id"], name: "index_user_expenses_on_expense_id"
    t.index ["user_id"], name: "index_user_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
