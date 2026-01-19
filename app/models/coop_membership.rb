class CoopMembership < ApplicationRecord
  belongs_to :cooperative
  belongs_to :individual
  has_many :insurance_contracts, as: :insured, dependent: :destroy
end
