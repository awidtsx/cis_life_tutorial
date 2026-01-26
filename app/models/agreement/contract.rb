class Agreement::Contract < ApplicationRecord
  has_many :agreement_rates, class_name: 'Agreement::Rate', foreign_key: :contract_id
  has_many :insurance_contracts, as: :agreement
  belongs_to :insurance_product
  belongs_to :contractable, polymorphic: true

  # Validations
  validates :contractable_type, presence: true
  validates :contractable_id, presence: true
  validates :insurance_product_id, presence: true
  validate :product_type_matches_contractable_type

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

  private

  def product_type_matches_contractable_type
    return unless insurance_product && contractable_type

    case contractable_type
    when 'Cooperative'
      unless insurance_product.product_type == 'group_policy'
        errors.add(:insurance_product_id, 'must be a Group product for Cooperative contracts')
      end
    when 'Individual'
      unless insurance_product.product_type == 'individual'
        errors.add(:insurance_product_id, 'must be an Individual product for Individual contracts')
      end
    end
  end
end