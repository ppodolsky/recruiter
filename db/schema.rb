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

ActiveRecord::Schema.define(version: 20131004204202) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["name", "resource_type", "resource_id"], name: "index_admins_on_name_and_resource_type_and_resource_id"
  add_index "admins", ["name"], name: "index_admins_on_name"

  create_table "categories", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_experiments", id: false, force: true do |t|
    t.integer "experiment_id"
    t.integer "category_id"
  end

  create_table "experimenters", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experimenters", ["name", "resource_type", "resource_id"], name: "index_experimenters_on_name_and_resource_type_and_resource_id"
  add_index "experimenters", ["name"], name: "index_experimenters_on_name"

  create_table "experiments", force: true do |t|
    t.string   "name"
    t.text     "decription", default: ""
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiments_experimenters", id: false, force: true do |t|
    t.integer "experiment_id"
    t.integer "experimenter_id"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "secondary_email"
    t.string   "first_name",      limit: 30
    t.string   "last_name",       limit: 30
    t.string   "phone",           limit: 14
    t.string   "gender",          limit: 1
    t.string   "ethnicity",       limit: 8
    t.integer  "age",             limit: 2
    t.string   "class_year"
    t.integer  "total_years",     limit: 2
    t.integer  "year_started"
    t.decimal  "current_gpa",                precision: 3, scale: 2
    t.integer  "years_resident",  limit: 2
    t.string   "profession"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["secondary_email"], name: "index_profiles_on_secondary_email", unique: true
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "sessions", force: true do |t|
    t.integer  "experiment_id"
    t.datetime "date_start"
    t.datetime "date_stop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions_subjects", id: false, force: true do |t|
    t.integer "session_id"
    t.integer "subject_id"
    t.boolean "invited",      default: false
    t.boolean "participated", default: false
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["name", "resource_type", "resource_id"], name: "index_subjects_on_name_and_resource_type_and_resource_id"
  add_index "subjects", ["name"], name: "index_subjects_on_name"

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "users_admins", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "admin_id"
  end

  add_index "users_admins", ["user_id", "admin_id"], name: "index_users_admins_on_user_id_and_admin_id"

  create_table "users_experimenters", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "experimenter_id"
  end

  add_index "users_experimenters", ["user_id", "experimenter_id"], name: "index_users_experimenters_on_user_id_and_experimenter_id"

  create_table "users_subjects", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "subject_id"
  end

  add_index "users_subjects", ["user_id", "subject_id"], name: "index_users_subjects_on_user_id_and_subject_id"

end
