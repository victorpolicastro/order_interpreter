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

ActiveRecord::Schema.define(version: 2021_01_15_190127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "neighborhood_id", null: false
    t.integer "external_code"
    t.string "address_line"
    t.string "street_name"
    t.string "street_number"
    t.string "comment"
    t.string "zip_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "receiver_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_addresses_on_buyer_id"
    t.index ["neighborhood_id"], name: "index_addresses_on_neighborhood_id"
  end

  create_table "billing_infos", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.string "doc_type"
    t.string "doc_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_billing_infos_on_buyer_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.integer "external_code"
    t.string "nickname"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "external_code"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.integer "external_code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "item_id", null: false
    t.decimal "quantity"
    t.decimal "unit_price"
    t.decimal "full_unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "external_code"
    t.integer "payer_id"
    t.integer "installments"
    t.string "payment_type"
    t.string "status"
    t.decimal "transaction_amount"
    t.decimal "taxes_amount"
    t.decimal "shipping_cost"
    t.decimal "total_paid_amount"
    t.decimal "installment_amount"
    t.datetime "date_approved"
    t.datetime "date_created"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_payments_on_order_id"
  end

  create_table "order_shippings", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "external_code"
    t.string "shipment_type"
    t.datetime "date_created"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_shippings_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "external_code"
    t.integer "store_id"
    t.datetime "date_created"
    t.datetime "date_closed"
    t.datetime "last_updated"
    t.decimal "total_amount"
    t.decimal "total_shipping"
    t.decimal "total_amount_with_shipping"
    t.decimal "paid_amount"
    t.datetime "expiration_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "buyer_id", null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
  end

  create_table "phones", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.integer "area_code"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_phones_on_buyer_id"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  add_foreign_key "addresses", "buyers"
  add_foreign_key "addresses", "neighborhoods"
  add_foreign_key "billing_infos", "buyers"
  add_foreign_key "cities", "states"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_payments", "orders"
  add_foreign_key "order_shippings", "orders"
  add_foreign_key "orders", "buyers"
  add_foreign_key "phones", "buyers"
  add_foreign_key "states", "countries"
end
