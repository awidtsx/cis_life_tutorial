class AddRateToInsuranceContracts < ActiveRecord::Migration[7.1]
  def change
        add_column :insurance_contracts, :rate, :decimal, precision: 10, scale: 2

  end
end
