class CreateAgreementContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :agreement_contracts do |t|
      t.references :insurance_product, null: false, foreign_key: true
      t.references :cooperative, null: false, foreign_key: true
      t.integer :agreement_number
      t.string  :status
      t.date    :moa

      t.references :producer, null: false, foreign_key: true
      t.string  :client_type

      t.references :cooperative, null: true, foreign_key: true
      t.references :individual,  null: true, foreign_key: true

      t.string  :payment_mode
      t.string  :commission_type
      t.integer :min_participation
      t.integer :grace_period_day

      t.text    :special_provision

      t.boolean :is_transferred_business, default: false
      t.boolean :with_claim_fund, default: false
      t.boolean :with_unused, default: false
      t.timestamps
    end
  end
end
