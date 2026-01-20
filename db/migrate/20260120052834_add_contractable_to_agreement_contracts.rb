class AddContractableToAgreementContracts < ActiveRecord::Migration[7.1]
  def change
     add_reference :agreement_contracts, :contractable, polymorphic: true, null: true
    add_index :agreement_contracts, [:contractable_type, :contractable_id]
  end
end
