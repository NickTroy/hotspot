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

ActiveRecord::Schema.define(version: 20160606080756) do

  create_table "collections_hotspot_images", force: :cascade do |t|
    t.integer  "hotspot_image_id", limit: 4
    t.integer  "collection_id",    limit: 8
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "collections_hotspot_images", ["hotspot_image_id"], name: "index_collections_hotspot_images_on_hotspot_image_id", using: :btree

  create_table "hotspot_images", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "interface_id", limit: 4
    t.string   "title",        limit: 255
  end

  add_index "hotspot_images", ["interface_id"], name: "index_hotspot_images_on_interface_id", using: :btree

  create_table "interfaces", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "shopify_domain", limit: 255, null: false
    t.string   "shopify_token",  limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true, using: :btree

  add_foreign_key "collections_hotspot_images", "hotspot_images"
  add_foreign_key "hotspot_images", "interfaces"
end
