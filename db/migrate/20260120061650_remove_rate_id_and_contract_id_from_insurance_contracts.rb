class RemoveRateIdAndContractIdFromInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
    remove_column :insurance_contracts, :rate_id, :integer
    remove_column :insurance_contracts, :contract_id, :integer
  end
end
