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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150730102807) do

  create_table "automation_builds", :force => true do |t|
    t.integer  "automation_job_id"
    t.string   "build_str"
    t.string   "number"
    t.string   "full_name"
    t.datetime "start_time"
    t.integer  "elapsed_time"
    t.integer  "duration"
    t.string   "result"
    t.boolean  "building"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "success_cases_count", :default => 0
    t.integer  "failed_cases_count",  :default => 0
  end

  create_table "automation_jobs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "automation_jobs_automation_sets", :id => false, :force => true do |t|
    t.integer "automation_set_id"
    t.integer "automation_job_id"
  end

  create_table "automation_sets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
