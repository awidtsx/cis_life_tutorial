class CreateInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_contracts do |t|
      t.references :rate, null: false, foreign_key: { to_table: :agreement_rates }
      t.references :insured, polymorphic: true, null: false
      t.integer :age
      t.decimal :amount_covered
      t.string :premium
      t.date :effectivity
      t.date :expiry

      t.timestamps
    end
  end
end
