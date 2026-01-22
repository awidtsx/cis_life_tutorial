class RemoveInsuranceGroupFromInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :insurance_contracts, :insurance_group, index: true
  end
end
