class InsuranceContract < ApplicationRecord
  belongs_to :rate, class_name: "Agreement::Rate", optional: true
  belongs_to :contract, class_name: "Agreement::Contract", optional: true
  belongs_to :insured, polymorphic: true
  before_validation :calculate_premium_value
  def term
    return 0 if effectivity.blank? || expiry.blank?

    (expiry.year * 12 + expiry.month) - (effectivity.year * 12 + effectivity.month)
  end

  def calculate_premium_value

    return if amount_covered.blank? || rate_id.blank? || effectivity.blank? || expiry.blank?


    self.premium = (amount_covered.to_f / 1000) * rate.rate.to_f * term
  end
end
