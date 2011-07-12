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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110509231247) do

  create_table "project_memberships", :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "user_id",    :null => false
    t.string   "role",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_memberships", ["project_id"], :name => "index_project_memberships_on_project_id"
  add_index "project_memberships", ["role"], :name => "index_project_memberships_on_role"
  add_index "project_memberships", ["user_id"], :name => "index_project_memberships_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name",                                      :null => false
    t.string   "iterations_start_on"
    t.date     "project_start_date"
    t.integer  "iteration_length"
    t.string   "estimation_unit"
    t.string   "unit_scale"
    t.integer  "initial_velocity"
    t.integer  "velocity_strategy"
    t.boolean  "points_for_other_types"
    t.boolean  "allow_best_and_worst"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",                                :null => false
    t.boolean  "private",                :default => false
  end

  add_index "projects", ["creator_id"], :name => "index_projects_on_creator_id"

  create_table "stories", :force => true do |t|
    t.string   "title",                  :null => false
    t.string   "story_type",             :null => false
    t.string   "estimate"
    t.integer  "requested_by_id",        :null => false
    t.integer  "owned_by_id"
    t.text     "description"
    t.integer  "project_id",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "state"
    t.integer  "best_case_estimate"
    t.integer  "worst_case_estimate"
    t.float    "expected_case_estimate"
    t.float    "estimate_deviation"
    t.float    "estimate_variance"
  end

  add_index "stories", ["owned_by_id"], :name => "index_stories_on_owned_by_id"
  add_index "stories", ["requested_by_id"], :name => "index_stories_on_requested_by_id"
  add_index "stories", ["story_type"], :name => "index_stories_on_story_type"

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
