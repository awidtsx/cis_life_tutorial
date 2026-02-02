class CreateAgreementEligibilities < ActiveRecord::Migration[7.1]
  def change
    create_table :agreement_eligibilities do |t|
      t.string :eligibility_title
      t.boolean :dependent
      t.decimal :evidence_limit
      t.decimal :medical_limit
      t.integer :contestability
      t.integer :min_entry
      t.integer :max_entry
      t.integer :exit
      t.decimal :service
      t.decimal :commission
      t.integer :min_confinement
      t.integer :max_confinement

      t.timestamps
    end
  end
end
