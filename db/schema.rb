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


ActiveRecord::Schema.define(version: 20170828093809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "photo"
    t.float "weight"
    t.string "activity_level"
    t.boolean "is_sterilized", default: false, null: false
    t.string "life_stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "body_condition_score"
    t.float "multiplier"
    t.string "size"
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "ingredient_id"
    t.float "amount"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_doses_on_ingredient_id"
    t.index ["recipe_id"], name: "index_doses_on_recipe_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "recipe_id"], name: "index_favorites_on_user_id_and_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.float "energy_kcal"
    t.float "protein_g"
    t.float "fat_g"
    t.float "fiber_g"
    t.float "calcium_mg"
    t.float "iron_mg"
    t.float "magnesium_mg"
    t.float "phosphorus_mg"
    t.float "potassium_mg"
    t.float "sodium_mg"
    t.float "zinc_mg"
    t.float "niacin_mg"
    t.float "pyridoxine_mg"
    t.float "folate_ug"
    t.float "vitamin_b12_ug"
    t.float "vitamin_a_iu"
    t.float "vitamin_e_mg"
    t.float "vitamin_d_iu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "riboflavin_mg"
    t.float "thiamin_mg"
  end

  create_table "nutrition_reqs", force: :cascade do |t|
    t.bigint "dog_id"
    t.float "energy_kcal"
    t.float "protein_g"
    t.float "fat_g"
    t.float "fiber_g"
    t.float "calcium_mg"
    t.float "iron_mg"
    t.float "magnesium_mg"
    t.float "phosphorus_mg"
    t.float "potassium_mg"
    t.float "sodium_mg"
    t.float "zinc_mg"
    t.float "niacin_mg"
    t.float "pyridoxine_mg"
    t.float "folate_ug"
    t.float "vitamin_b12_ug"
    t.float "vitamin_a_iu"
    t.float "vitamin_e_mg"
    t.float "vitamin_d_iu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "riboflavin_mg"
    t.float "thiamin_mg"
    t.index ["dog_id"], name: "index_nutrition_reqs_on_dog_id"
  end

  create_table "recipe_nutrition_infos", force: :cascade do |t|
    t.bigint "recipe_id"
    t.float "energy_kcal", default: 0.0
    t.float "protein_g", default: 0.0
    t.float "fat_g", default: 0.0
    t.float "fiber_g", default: 0.0
    t.float "calcium_mg", default: 0.0
    t.float "iron_mg", default: 0.0
    t.float "magnesium_mg", default: 0.0
    t.float "phosphorus_mg", default: 0.0
    t.float "potassium_mg", default: 0.0
    t.float "sodium_mg", default: 0.0
    t.float "zinc_mg", default: 0.0
    t.float "thiamin_mg", default: 0.0
    t.float "riboflavin_mg", default: 0.0
    t.float "niacin_mg", default: 0.0
    t.float "pyridoxine_mg", default: 0.0
    t.float "folate_ug", default: 0.0
    t.float "vitamin_b12_ug", default: 0.0
    t.float "vitamin_a_iu", default: 0.0
    t.float "vitamin_e_mg", default: 0.0
    t.float "vitamin_d_iu", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_nutrition_infos_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.bigint "dog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["dog_id"], name: "index_recipes_on_dog_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "dogs", "users", on_delete: :cascade
  add_foreign_key "doses", "ingredients"
  add_foreign_key "doses", "recipes"
  add_foreign_key "favorites", "recipes", on_delete: :cascade
  add_foreign_key "favorites", "users", on_delete: :cascade
  add_foreign_key "nutrition_reqs", "dogs", on_delete: :cascade
  add_foreign_key "recipe_nutrition_infos", "recipes", on_delete: :cascade
  add_foreign_key "recipes", "dogs", on_delete: :cascade
end
