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

ActiveRecord::Schema.define(version: 20170621161037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "editors", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operating_systems_rooms", id: false, force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "operating_system_id", null: false
  end

  create_table "operating_systems_versions", id: false, force: :cascade do |t|
    t.bigint "version_id", null: false
    t.bigint "operating_system_id", null: false
  end

  create_table "pcs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.index ["room_id"], name: "index_pcs_on_room_id"
  end

  create_table "pcs_versions", id: false, force: :cascade do |t|
    t.bigint "version_id", null: false
    t.bigint "pc_id", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "cheveux"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "editor_id"
    t.string "short_desc"
    t.string "compatibility"
    t.index ["editor_id"], name: "index_programs_on_editor_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "building"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_versions", id: false, force: :cascade do |t|
    t.bigint "version_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.boolean "distrilog"
    t.string "install_link"
    t.string "website"
    t.text "presentation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "program_id"
    t.index ["program_id"], name: "index_versions_on_program_id"
  end

  add_foreign_key "pcs", "rooms"
  add_foreign_key "programs", "editors"
  add_foreign_key "versions", "programs"
end
