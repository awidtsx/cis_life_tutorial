class ChangePremiumToDecimalInInsuranceContract < ActiveRecord::Migration[7.1]
  def change
        change_column :insurance_contracts, :premium, :decimal, precision: 15, scale: 2

  end
end
