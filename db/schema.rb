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

ActiveRecord::Schema.define(version: 20150615062635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["username"], name: "index_admins_on_username", unique: true, using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "chapter_id"
    t.integer  "offset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookmarks", ["book_id"], name: "index_bookmarks_on_book_id", using: :btree
  add_index "bookmarks", ["chapter_id"], name: "index_bookmarks_on_chapter_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.integer  "word_count"
    t.integer  "admin_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "category"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "state"
  end

  add_index "books", ["admin_id"], name: "index_books_on_admin_id", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.integer  "book_id"
    t.text     "content"
    t.integer  "word_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "chapters", ["book_id"], name: "index_chapters_on_book_id", using: :btree

  add_foreign_key "bookmarks", "books"
  add_foreign_key "bookmarks", "chapters"
  add_foreign_key "books", "admins"
  add_foreign_key "chapters", "books"
end
