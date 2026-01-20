class InsuranceContract < ApplicationRecord
  belongs_to :agreement, polymorphic: true
  belongs_to :insured, polymorphic: true
  
  before_validation :calculate_premium_value
  
  def term
    return 0 if effectivity.blank? || expiry.blank?

    (expiry.year * 12 + expiry.month) - (effectivity.year * 12 + effectivity.month)
  end

  def calculate_premium_value
    return if amount_covered.blank? || agreement.blank? || effectivity.blank? || expiry.blank?

    rate_value = case agreement_type
    when 'Agreement::Rate'
      agreement.rate
    when 'Agreement::Contract'

      0
    else
      return
    end

    self.premium = (amount_covered.to_f / 1000) * rate_value.to_f * term
  end

  def rate_value
    case agreement_type
    when 'Agreement::Rate'
      agreement&.rate
    when 'Agreement::Contract'
      0
    else
      0
    end
  end
end