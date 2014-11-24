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

ActiveRecord::Schema.define(version: 20141124072533) do

  create_table "bills", force: true do |t|
    t.string   "bill_number"
    t.string   "name"
    t.string   "committee"
    t.boolean  "passed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chamber"
    t.integer  "cosponsors_count"
    t.string   "enacted_as"
    t.date     "introduced_on"
    t.date     "last_action_at"
    t.date     "last_vote_at"
    t.integer  "number"
    t.text     "official_title"
    t.string   "sponsor_id"
  end

  create_table "invites", force: true do |t|
    t.integer  "league_id"
    t.string   "session_key"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "politicians", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "state"
    t.text     "biography"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bioguide_id"
    t.boolean  "in_office"
    t.string   "govtrack_id"
    t.string   "crp_id"
    t.string   "gender"
    t.date     "birthday"
    t.string   "leadership_role"
    t.date     "term_start"
    t.date     "term_end"
    t.string   "state_name"
    t.string   "title"
    t.string   "chamber"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "office"
    t.string   "contact_form"
    t.string   "oc_email"
    t.string   "ocd_id"
  end

  create_table "rosters", force: true do |t|
    t.integer  "team_id"
    t.integer  "politician_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", force: true do |t|
    t.integer  "politician_id"
    t.integer  "bill_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.string   "team_name"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.integer  "points"
    t.integer  "status"
    t.boolean  "is_moderator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.string  "ammendment_number"
    t.string  "bill_number"
    t.string  "chamber"
    t.integer "number"
    t.string  "question"
    t.string  "required"
    t.string  "result"
    t.string  "vote_type"
    t.date    "voted_at"
    t.string  "year"
  end

end
