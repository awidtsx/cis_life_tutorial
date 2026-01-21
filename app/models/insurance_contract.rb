class InsuranceContract < ApplicationRecord
  belongs_to :agreement, polymorphic: true
  belongs_to :insured, polymorphic: true
  belongs_to :insurance_group, optional: true
  
  # Validate that rate is present
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def term
    return 0 if effectivity.blank? || expiry.blank?

    (expiry.year * 12 + expiry.month) - (effectivity.year * 12 + effectivity.month)
  end

  # Return the stored rate value
  def rate_value
    rate
  end

  def display_rate
    return 'N/A' if rate.blank?
    "#{rate}%"
  end
  
  # Helper method to get the agreement rate (for reference only, not used for calculations)
  def agreement_rate
    case agreement_type
    when 'Agreement::Rate'
      agreement&.rate
    when 'Agreement::Contract'
      nil
    else
      nil
    end
  end
  
  # Check if this is a group contract
  def group_contract?
    insurance_group_id.present?
  end
end