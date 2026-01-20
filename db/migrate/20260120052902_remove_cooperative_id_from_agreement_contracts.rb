class RemoveCooperativeIdFromAgreementContracts < ActiveRecord::Migration[7.1]
  def change
    remove_column :agreement_contracts, :cooperative_id, :integer
  end
end
