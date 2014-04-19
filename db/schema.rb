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

ActiveRecord::Schema.define(version: 20140419114946) do

  create_table "hcpcs", force: true do |t|
    t.string   "code",        limit: 5
    t.string   "description", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hcpcs", ["code"], name: "index_hcpcs_on_code", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "provider_id"
    t.string   "place_of_service",     limit: 1
    t.string   "hcpcs_code",           limit: 5
    t.integer  "line_srvc_cnt"
    t.integer  "bene_unique_cnt"
    t.integer  "bene_day_srvc_cnt"
    t.integer  "avg_mc_allowed_amt"
    t.integer  "stdev_mc_allowed_amt"
    t.integer  "avg_sub_chrg_amt"
    t.integer  "stdev_sub_chrg_amt"
    t.integer  "avg_mc_pmt_amt"
    t.integer  "stdev_mc_pmt_amt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["provider_id"], name: "index_payments_on_provider_id", using: :btree

  create_table "providers", force: true do |t|
    t.integer  "npi",              limit: 8
    t.string   "last_org_name",    limit: 70
    t.string   "first_name",       limit: 20
    t.string   "mi",               limit: 1
    t.string   "credentials",      limit: 20
    t.string   "gender",           limit: 1
    t.string   "entity_code",      limit: 1
    t.string   "street1",          limit: 55
    t.string   "street2",          limit: 55
    t.string   "city",             limit: 40
    t.string   "zip",              limit: 20
    t.string   "state",            limit: 2
    t.string   "country",          limit: 2
    t.string   "specialty",        limit: 43
    t.string   "mc_participation", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_pmt",        limit: 8
  end

  add_index "providers", ["npi"], name: "index_providers_on_npi", unique: true, using: :btree

  create_table "specialties", force: true do |t|
    t.string   "name",       limit: 43
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_pmt",  limit: 8
    t.integer  "max_pmt",    limit: 8
    t.integer  "avg_pmt",    limit: 8
  end

end
