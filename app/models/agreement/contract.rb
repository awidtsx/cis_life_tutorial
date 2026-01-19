class Agreement::Contract < ApplicationRecord
  has_many :agreement_rates, foreign_key: :contract_id
  has_many :insurance_groups, foreign_key: :contract_id, dependent: :destroy
  belongs_to :insurance_product
  belongs_to :cooperative

end
