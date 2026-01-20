class AddAgreementToInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
    add_reference :insurance_contracts, :agreement, polymorphic: true, null: true
    add_index :insurance_contracts, [:agreement_type, :agreement_id]
  end
end
