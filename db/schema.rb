# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_25_190937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_carts_on_token", unique: true
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "venue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_floors_on_slug"
    t.index ["venue_id"], name: "index_floors_on_venue_id"
  end

  create_table "seat_selections", force: :cascade do |t|
    t.bigint "seat_id", null: false
    t.bigint "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_seat_selections_on_cart_id"
    t.index ["seat_id", "cart_id"], name: "index_seat_selections_on_seat_id_and_cart_id", unique: true
    t.index ["seat_id"], name: "index_seat_selections_on_seat_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "row", null: false
    t.string "number", null: false
    t.integer "x", null: false
    t.integer "y", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_seats_on_number"
    t.index ["row"], name: "index_seats_on_row"
    t.index ["section_id"], name: "index_seats_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "floor_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["floor_id"], name: "index_sections_on_floor_id"
    t.index ["slug"], name: "index_sections_on_slug"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_venues_on_slug"
  end

  add_foreign_key "floors", "venues"
  add_foreign_key "seat_selections", "carts"
  add_foreign_key "seat_selections", "seats"
  add_foreign_key "seats", "sections"
  add_foreign_key "sections", "floors"
end
