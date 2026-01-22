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

ActiveRecord::Schema[7.1].define(version: 2026_01_21_081154) do
  create_table "add_barangays", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "add_municipal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["add_municipal_id"], name: "index_add_barangays_on_add_municipal_id"
  end

  create_table "add_municipals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "add_province_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["add_province_id"], name: "index_add_municipals_on_add_province_id"
  end

  create_table "add_provinces", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "add_region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["add_region_id"], name: "index_add_provinces_on_add_region_id"
  end

  create_table "add_regions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_contracts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "insurance_product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contractable_type"
    t.bigint "contractable_id"
    t.index ["contractable_type", "contractable_id"], name: "idx_on_contractable_type_contractable_id_5b54a6533b"
    t.index ["contractable_type", "contractable_id"], name: "index_agreement_contracts_on_contractable"
    t.index ["insurance_product_id"], name: "index_agreement_contracts_on_insurance_product_id"
  end

  create_table "agreement_rates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.integer "age_from"
    t.integer "age_to"
    t.decimal "rate", precision: 10
    t.decimal "min_amount", precision: 10
    t.decimal "max_amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_agreement_rates_on_contract_id"
  end

  create_table "coop_memberships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cooperative_id", null: false
    t.bigint "individual_id", null: false
    t.date "membership_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooperative_id"], name: "index_coop_memberships_on_cooperative_id"
    t.index ["individual_id"], name: "index_coop_memberships_on_individual_id"
  end

  create_table "cooperatives", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "add_region_id", null: false
    t.bigint "add_province_id", null: false
    t.bigint "add_municipal_id", null: false
    t.bigint "add_barangay_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["add_barangay_id"], name: "index_cooperatives_on_add_barangay_id"
    t.index ["add_municipal_id"], name: "index_cooperatives_on_add_municipal_id"
    t.index ["add_province_id"], name: "index_cooperatives_on_add_province_id"
    t.index ["add_region_id"], name: "index_cooperatives_on_add_region_id"
  end

  create_table "individuals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "mi"
    t.date "birth_date"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurance_contracts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "insured_type", null: false
    t.bigint "insured_id", null: false
    t.integer "age"
    t.decimal "amount_covered", precision: 10
    t.decimal "premium", precision: 15, scale: 2
    t.date "effectivity"
    t.date "expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_type"
    t.bigint "agreement_id"
    t.decimal "rate", precision: 10, scale: 2
    t.index ["agreement_type", "agreement_id"], name: "index_insurance_contracts_on_agreement"
    t.index ["agreement_type", "agreement_id"], name: "index_insurance_contracts_on_agreement_type_and_agreement_id"
    t.index ["insured_type", "insured_id"], name: "index_insurance_contracts_on_insured"
  end

  create_table "insurance_groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "insurance_contract_id"
    t.bigint "cooperative_id", null: false
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_insurance_groups_on_contract_id"
    t.index ["cooperative_id"], name: "index_insurance_groups_on_cooperative_id"
    t.index ["insurance_contract_id"], name: "index_insurance_groups_on_insurance_contract_id"
  end

  create_table "insurance_products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "product_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "add_barangays", "add_municipals"
  add_foreign_key "add_municipals", "add_provinces"
  add_foreign_key "add_provinces", "add_regions"
  add_foreign_key "agreement_contracts", "insurance_products"
  add_foreign_key "agreement_rates", "agreement_contracts", column: "contract_id"
  add_foreign_key "coop_memberships", "cooperatives"
  add_foreign_key "coop_memberships", "individuals"
  add_foreign_key "cooperatives", "add_barangays"
  add_foreign_key "cooperatives", "add_municipals"
  add_foreign_key "cooperatives", "add_provinces"
  add_foreign_key "cooperatives", "add_regions"
  add_foreign_key "insurance_groups", "agreement_contracts", column: "contract_id"
  add_foreign_key "insurance_groups", "cooperatives"
  add_foreign_key "insurance_groups", "insurance_contracts"
end
