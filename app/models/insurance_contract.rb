class InsuranceContract < ApplicationRecord
  belongs_to :agreement, polymorphic: true
  belongs_to :insured, polymorphic: true
  
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
  
  # Check if this is a group contract by checking if the insured's cooperative has an insurance group
  # with an agreement contract that has this contract's agreement_rate
  def group_contract?
    return false unless insured.is_a?(CoopMembership)
    return false unless agreement_type == 'Agreement::Rate'
    
    insurance_group.present?
  end
  
  # Get the insurance group if this is a group contract
  def insurance_group
    return nil unless insured.is_a?(CoopMembership)
    return nil unless agreement_type == 'Agreement::Rate'
    
    cooperative = insured.cooperative
    rate_contract = agreement.contract
    
    InsuranceGroup.find_by(
      cooperative_id: cooperative.id,
      contract_id: rate_contract.id
    )
  end
end