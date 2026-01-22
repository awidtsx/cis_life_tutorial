class Agreement::Contract < ApplicationRecord
  has_many :agreement_rates, class_name: 'Agreement::Rate', foreign_key: :contract_id
  has_many :insurance_contracts, as: :agreement
  belongs_to :insurance_product
  belongs_to :contractable, polymorphic: true

  def contractable_name
    case contractable
      when Cooperative
        contractable.name
      when Individual
        contractable.full_name
      else
      'N/A'
    end
  end


end
