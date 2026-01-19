class CreateAgreementContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :agreement_contracts do |t|
      t.references :insurance_product, null: false, foreign_key: true
      t.references :cooperative, null: false, foreign_key: true

      t.timestamps
    end
  end
end
