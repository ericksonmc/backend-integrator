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

ActiveRecord::Schema.define(version: 2022_03_03_223448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "award_details", force: :cascade do |t|
    t.integer "ticket_id"
    t.float "amount"
    t.integer "status", default: 0, null: false
    t.bigint "award_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "reaward", default: false
    t.integer "bet_id"
    t.jsonb "response"
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
    t.jsonb "users", default: {}
    t.string "legal_name"
    t.string "dni"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "lottery_setups", force: :cascade do |t|
    t.float "mmt"
    t.float "mpj"
    t.float "jpt"
    t.float "mt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "active"
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_permissions_on_section_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
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
    t.string "currency"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "rules"
    t.string "url"
    t.integer "type_product"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "pretty_name"
    t.integer "module_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "number"
    t.string "confirm"
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
    t.jsonb "response"
    t.index ["player_id"], name: "index_tickets_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.bigint "integrator_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["integrator_id"], name: "index_users_on_integrator_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bets", "players"
  add_foreign_key "bets", "tickets"
  add_foreign_key "permissions", "sections"
  add_foreign_key "permissions", "users"
  add_foreign_key "tickets", "players"
  add_foreign_key "users", "integrators"
end
