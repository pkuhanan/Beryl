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

ActiveRecord::Schema.define(version: 20170603173801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.string "name"
    t.string "data_type"
    t.boolean "multiple"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "columns_logbooks", id: false, force: :cascade do |t|
    t.bigint "logbook_id"
    t.bigint "column_id"
    t.index ["column_id"], name: "index_columns_logbooks_on_column_id"
    t.index ["logbook_id", "column_id"], name: "index_columns_logbooks_on_logbook_id_and_column_id", unique: true
    t.index ["logbook_id"], name: "index_columns_logbooks_on_logbook_id"
  end

  create_table "data_entries", force: :cascade do |t|
    t.bigint "entry_id"
    t.bigint "column_id"
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_data_entries_on_column_id"
    t.index ["entry_id"], name: "index_data_entries_on_entry_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "logbook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["logbook_id"], name: "index_entries_on_logbook_id"
  end

  create_table "logbooks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "private", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logbooks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.boolean "admin"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "data_entries", "columns"
  add_foreign_key "data_entries", "entries"
  add_foreign_key "entries", "logbooks"
  add_foreign_key "logbooks", "users"
end
