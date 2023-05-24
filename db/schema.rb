# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_17_203231) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "contaduria", null: false
    t.string "name"
    t.string "prefix"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "condition", null: false
    t.string "physical_folio", null: false
    t.string "system_folio", null: false
    t.date "physical_date", null: false
    t.date "system_date", null: false
    t.integer "total_amount_cents", null: false
    t.string "place", null: false
    t.integer "status", default: 0, null: false
    t.bigint "client_id"
    t.bigint "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_user_id"
    t.index ["admin_user_id"], name: "index_invoices_on_admin_user_id"
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["seller_id"], name: "index_invoices_on_seller_id"
    t.index ["status"], name: "index_invoices_on_status"
    t.index ["system_folio"], name: "index_invoices_on_system_folio"
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1, null: false
    t.integer "unit_price_cents"
    t.datetime "completed_at", precision: nil
    t.integer "final_quantity"
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "folio"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_user_id", null: false
    t.bigint "client_id", null: false
    t.integer "sequential_id"
    t.text "comments"
    t.index ["admin_user_id"], name: "index_orders_on_admin_user_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "payment_logs", force: :cascade do |t|
    t.integer "total_amount_cents", null: false
    t.string "folio", null: false
    t.integer "status", default: 0, null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "voucher"
    t.integer "invoice_id"
    t.date "physical_date"
    t.index ["client_id"], name: "index_payment_logs_on_client_id"
    t.index ["status"], name: "index_payment_logs_on_status"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount_cents", null: false
    t.bigint "payment_log_id"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "seller_id"
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_payments_on_deleted_at"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["payment_log_id"], name: "index_payments_on_payment_log_id"
    t.index ["seller_id"], name: "index_payments_on_seller_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "sku", null: false
    t.string "name", null: false
    t.string "line"
    t.string "aux_sku"
    t.string "in_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_options", default: [], array: true
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "admin_users"
  add_foreign_key "orders", "clients"
end
