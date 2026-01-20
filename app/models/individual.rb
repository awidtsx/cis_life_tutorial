class Individual < ApplicationRecord
has_many :insurance_contracts, as: :insured, dependent: :destroy
has_many :contracts, as: :contractable, class_name: "Agreement::Contract"
  def full_name
    "#{last_name}, #{first_name} #{mi}"
  end
end
