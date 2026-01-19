class AddContractToInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
           add_reference :insurance_contracts, :contract, 
                  foreign_key: { to_table: :agreement_contracts }, 
                  null: true
  end
end
