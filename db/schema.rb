# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150830220629) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.integer  "house_number"
    t.string   "postcode"
    t.string   "country"
    t.integer  "customer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_items", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "item_id",     null: false
  end

  add_index "categories_items", ["category_id", "item_id"], name: "index_categories_items_on_category_id_and_item_id"
  add_index "categories_items", ["item_id", "category_id"], name: "index_categories_items_on_item_id_and_category_id"

  create_table "customers", force: :cascade do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.decimal  "price",              precision: 12, scale: 2
    t.string   "currency",                                    default: "EUR"
    t.string   "quantitiy_unit"
    t.string   "quantity_unit"
  end

  create_table "ordered_items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "item_id"
    t.integer  "customer_id"
    t.boolean  "is_in_process", default: false
    t.boolean  "is_dispatched", default: false
    t.boolean  "is_delivered",  default: false
    t.boolean  "is_rejected",   default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "paid"
  end

  add_index "ordered_items", ["customer_id"], name: "index_ordered_items_on_customer_id"
  add_index "ordered_items", ["item_id"], name: "index_ordered_items_on_item_id"

end
