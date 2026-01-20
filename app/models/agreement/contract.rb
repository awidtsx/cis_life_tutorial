class Agreement::Contract < ApplicationRecord
  has_many :agreement_rates, foreign_key: :contract_id
  has_many :insurance_contracts, as: :agreement
  belongs_to :insurance_product
  belongs_to :contractable, polymorphic: true

  def contractable_name
    contractable&.name || contractable&.full_name || 'N/A'
  end

end
