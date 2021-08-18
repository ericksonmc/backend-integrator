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

ActiveRecord::Schema.define(version: 2021_08_18_004752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "award_details", force: :cascade do |t|
    t.integer "ticket_id"
    t.float "amount"
    t.integer "status", default: 0, null: false
    t.bigint "award_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_id"], name: "index_award_details_on_award_id"
  end

  create_table "awards", force: :cascade do |t|
    t.string "number"
    t.integer "draw_id"
    t.jsonb "info_re_award"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.float "amount"
    t.float "prize"
    t.boolean "played"
    t.integer "bet_statu_id"
    t.integer "lotery_id"
    t.string "number"
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "remote_bet_id"
    t.index ["player_id"], name: "index_bets_on_player_id"
    t.index ["ticket_id"], name: "index_bets_on_ticket_id"
  end

  create_table "integrators", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "email"
    t.string "apikey"
    t.boolean "status"
    t.jsonb "product_settings"
    t.jsonb "setting_apis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lottery_setups", force: :cascade do |t|
    t.float "mmt"
    t.float "mpj"
    t.float "jpt"
    t.float "mt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "email"
    t.string "cedula"
    t.string "player_id"
    t.string "company"
    t.string "site"
    t.integer "integrator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "password"
    t.string "token"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "rules"
    t.string "url"
    t.integer "type_product"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "number"
    t.integer "confirm"
    t.float "total_amount"
    t.integer "cant_bets"
    t.integer "remote_user_id"
    t.integer "ticket_status_id"
    t.float "prize"
    t.boolean "payed"
    t.integer "remote_center_id"
    t.integer "remote_agency_id"
    t.integer "remote_group_id"
    t.integer "remote_master_center_id"
    t.integer "date_pay"
    t.string "security"
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ticket_string"
    t.index ["player_id"], name: "index_tickets_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bets", "players"
  add_foreign_key "bets", "tickets"
  add_foreign_key "tickets", "players"
end
