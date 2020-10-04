# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_27_225543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "contaduria", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "condition", null: false
    t.string "physical_folio", null: false
    t.string "system_folio", null: false
    t.datetime "physical_date", null: false
    t.datetime "system_date", null: false
    t.integer "total_amount_cents", null: false
    t.string "place", null: false
    t.integer "status", default: 0, null: false
    t.bigint "client_id"
    t.bigint "seller_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["seller_id"], name: "index_invoices_on_seller_id"
    t.index ["status"], name: "index_invoices_on_status"
    t.index ["system_folio"], name: "index_invoices_on_system_folio"
  end

  create_table "payment_logs", force: :cascade do |t|
    t.integer "total_amount_cents", null: false
    t.string "folio", null: false
    t.integer "status", default: 0, null: false
    t.bigint "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_payment_logs_on_client_id"
    t.index ["status"], name: "index_payment_logs_on_status"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount_cents", null: false
    t.bigint "payment_log_id"
    t.bigint "invoice_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["payment_log_id"], name: "index_payments_on_payment_log_id"
    t.index ["seller_id"], name: "index_payments_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
