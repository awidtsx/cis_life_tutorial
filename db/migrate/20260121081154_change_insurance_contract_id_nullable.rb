class ChangeInsuranceContractIdNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :insurance_groups, :insurance_contract_id, true
  end
end
