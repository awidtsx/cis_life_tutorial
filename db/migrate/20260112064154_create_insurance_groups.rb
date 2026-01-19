class CreateInsuranceGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_groups do |t|
      t.references :insurance_contract, null: false, foreign_key: true
      t.references :cooperative, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: { to_table: :agreement_contracts }

      t.timestamps
    end
  end
end
