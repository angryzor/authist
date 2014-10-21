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

ActiveRecord::Schema.define(version: 20141021160014) do

  create_table "role_subscriptions", force: true do |t|
    t.integer "role_id"
    t.integer "authorizable_id"
    t.string  "authorizable_type"
  end

  add_index "role_subscriptions", ["authorizable_id", "authorizable_type"], name: "index_role_subs_on_auth_id_and_auth_type_authist"
  add_index "role_subscriptions", ["role_id"], name: "index_role_subscriptions_on_role_id"

  create_table "roles", force: true do |t|
    t.string  "name"
    t.boolean "shoe_lacing"
  end

  create_table "roles_roles", force: true do |t|
    t.integer "role_id"
    t.integer "includer_id"
  end

  add_index "roles_roles", ["includer_id"], name: "index_roles_roles_on_includer_id"
  add_index "roles_roles", ["role_id"], name: "index_roles_roles_on_role_id"

  create_table "users", force: true do |t|
    t.string "username"
  end

end
