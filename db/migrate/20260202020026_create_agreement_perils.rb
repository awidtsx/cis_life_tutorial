class CreateAgreementPerils < ActiveRecord::Migration[7.1]
  def change
    create_table :agreement_perils do |t|
      t.references :eligibility, null: false, foreign_key: { to_table: :agreement_eligibilities }
      t.string :peril
      t.decimal :coverage
      t.decimal :premium
      t.string :description
      t.string :acronym

      t.timestamps
    end
  end
end
