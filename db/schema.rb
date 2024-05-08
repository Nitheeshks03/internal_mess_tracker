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

ActiveRecord::Schema[7.1].define(version: 2024_05_08_094729) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meal_logs", force: :cascade do |t|
    t.date "meal_date"
    t.boolean "breakfast"
    t.boolean "lunch"
    t.boolean "dinner"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_meal_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "meal_logs", "users"
end
