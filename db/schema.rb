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

ActiveRecord::Schema.define(version: 20140629181818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: true do |t|
    t.text     "body",         null: false
    t.integer  "sender_id",    null: false
    t.integer  "recipient_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "user_id",        null: false
    t.text     "summary"
    t.text     "job"
    t.text     "fortes"
    t.text     "physical_forte"
    t.text     "likes"
    t.text     "six_things"
    t.text     "think_about"
    t.text     "friday_night"
    t.text     "most_private"
    t.integer  "religion"
    t.integer  "ethnicity"
    t.string   "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "gender",          null: false
    t.string   "orientation",     null: false
    t.integer  "min_age",         null: false
    t.integer  "max_age",         null: false
    t.date     "dob",             null: false
    t.string   "country",         null: false
    t.string   "session_token",   null: false
    t.integer  "zip_code"
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
