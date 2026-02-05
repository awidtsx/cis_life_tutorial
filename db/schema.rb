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

ActiveRecord::Schema[7.1].define(version: 2026_02_05_054232) do
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

  create_table "agreement_eligibilities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "eligibility_title"
    t.boolean "dependent"
    t.decimal "evidence_limit", precision: 10
    t.decimal "medical_limit", precision: 10
    t.integer "contestability"
    t.integer "min_entry"
    t.integer "max_entry"
    t.integer "exit"
    t.decimal "service", precision: 10
    t.decimal "commission", precision: 10
    t.integer "min_confinement"
    t.integer "max_confinement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_perils", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "eligibility_id", null: false
    t.string "peril"
    t.decimal "coverage", precision: 10
    t.decimal "premium", precision: 10
    t.string "description"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eligibility_id"], name: "index_agreement_perils_on_eligibility_id"
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

  create_table "branch_offices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "territory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["territory_id"], name: "index_branch_offices_on_territory_id"
  end

  create_table "branches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "cooperative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooperative_id"], name: "index_branches_on_cooperative_id"
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

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dependents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.date "birthdate"
    t.string "gender"
    t.bigint "relationship_id", null: false
    t.bigint "individual_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["individual_id"], name: "index_dependents_on_individual_id"
    t.index ["relationship_id"], name: "index_dependents_on_relationship_id"
  end

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "cooperative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooperative_id"], name: "index_employees_on_cooperative_id"
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

  create_table "permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "create", default: false, null: false
    t.boolean "read", default: false, null: false
    t.boolean "update", default: false, null: false
    t.boolean "delete", default: false, null: false
  end

  create_table "producers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "cooperative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooperative_id"], name: "index_registries_on_cooperative_id"
  end

  create_table "relationships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_type"
    t.integer "agreement_id"
    t.index ["agreement_type", "agreement_id"], name: "index_relationships_on_agreement_type_and_agreement_id"
  end

  create_table "rolepermissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_rolepermissions_on_permission_id"
    t.index ["role_id"], name: "index_rolepermissions_on_role_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "territories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "cooperative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooperative_id"], name: "index_types_on_cooperative_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birthdate"
    t.string "first_name"
    t.string "last_name"
    t.string "designation"
    t.string "gender"
    t.bigint "branch_id"
    t.bigint "cooperative_id"
    t.bigint "department_id"
    t.boolean "active"
    t.bigint "role_id"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["cooperative_id"], name: "index_users_on_cooperative_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "add_barangays", "add_municipals"
  add_foreign_key "add_municipals", "add_provinces"
  add_foreign_key "add_provinces", "add_regions"
  add_foreign_key "agreement_contracts", "insurance_products"
  add_foreign_key "agreement_perils", "agreement_eligibilities", column: "eligibility_id"
  add_foreign_key "agreement_rates", "agreement_contracts", column: "contract_id"
  add_foreign_key "branch_offices", "territories"
  add_foreign_key "branches", "cooperatives"
  add_foreign_key "coop_memberships", "cooperatives"
  add_foreign_key "coop_memberships", "individuals"
  add_foreign_key "cooperatives", "add_barangays"
  add_foreign_key "cooperatives", "add_municipals"
  add_foreign_key "cooperatives", "add_provinces"
  add_foreign_key "cooperatives", "add_regions"
  add_foreign_key "dependents", "individuals"
  add_foreign_key "dependents", "relationships"
  add_foreign_key "employees", "cooperatives"
  add_foreign_key "insurance_groups", "agreement_contracts", column: "contract_id"
  add_foreign_key "insurance_groups", "cooperatives"
  add_foreign_key "insurance_groups", "insurance_contracts"
  add_foreign_key "registries", "cooperatives"
  add_foreign_key "rolepermissions", "permissions"
  add_foreign_key "rolepermissions", "roles"
  add_foreign_key "types", "cooperatives"
  add_foreign_key "users", "cooperatives"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "roles"
end
