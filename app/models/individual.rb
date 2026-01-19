class Individual < ApplicationRecord
has_many :insurance_contracts, as: :insured, dependent: :destroy
      
  def full_name
    "#{last_name}, #{first_name} #{mi}"
  end
end
