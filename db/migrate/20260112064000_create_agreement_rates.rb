class CreateAgreementRates < ActiveRecord::Migration[7.1]
  def change
    create_table :agreement_rates do |t|
      t.references :contract, null: false, foreign_key: { to_table: :agreement_contracts }
      t.integer :age_from
      t.integer :age_to
      t.decimal :rate
      t.decimal :min_amount
      t.decimal :max_amount

      t.timestamps
    end
  end
end
