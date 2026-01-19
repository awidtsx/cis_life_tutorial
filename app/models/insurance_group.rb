class InsuranceGroup < ApplicationRecord
  belongs_to :insurance_contract
  belongs_to :cooperative
  belongs_to :contract, class_name: "Agreement::Contract"
end
