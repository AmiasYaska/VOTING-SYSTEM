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

ActiveRecord::Schema[8.0].define(version: 2025_03_25_203936) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.bigint "position_id", null: false
    t.string "name"
    t.string "qualification"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_candidates_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "max_winners", default: 1
    t.integer "priority"
    t.boolean "voting_open", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "role"
    t.boolean "has_voted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "temporary_password"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "candidate_id", null: false
    t.bigint "position_id", null: false
    t.string "status", default: "draft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["position_id"], name: "index_votes_on_position_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "candidates", "positions"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "positions"
  add_foreign_key "votes", "users"
end
