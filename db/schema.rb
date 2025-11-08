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

ActiveRecord::Schema[8.0].define(version: 2025_11_07_000006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "key"
    t.string "scopes", default: [], array: true
    t.integer "rate_limit", default: 1000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_api_keys_on_key", unique: true
    t.index ["organization_id"], name: "index_api_keys_on_organization_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "url", null: false
    t.integer "status", default: 0
    t.integer "refresh_interval", default: 60
    t.jsonb "parser_settings", default: {}
    t.datetime "last_fetched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_feeds_on_organization_id"
    t.index ["url"], name: "index_feeds_on_url"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.string "guid", null: false
    t.string "title"
    t.string "link"
    t.text "content"
    t.datetime "published_at"
    t.datetime "fetched_at"
    t.string "hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id", "guid"], name: "index_items_on_feed_id_and_guid", unique: true
    t.index ["feed_id"], name: "index_items_on_feed_id"
    t.index ["published_at"], name: "index_items_on_published_at"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.integer "role", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "email"], name: "index_users_on_organization_id_and_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  create_table "webhooks", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "feed_id"
    t.string "url", null: false
    t.string "secret"
    t.string "events", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_webhooks_on_feed_id"
    t.index ["organization_id"], name: "index_webhooks_on_organization_id"
  end

  add_foreign_key "api_keys", "organizations"
  add_foreign_key "feeds", "organizations"
  add_foreign_key "items", "feeds"
  add_foreign_key "users", "organizations"
  add_foreign_key "webhooks", "feeds"
  add_foreign_key "webhooks", "organizations"
end
