class Agreement::Rate < ApplicationRecord
    has_many :insurance_contracts, foreign_key: :rate_id
    belongs_to :contract, class_name: "Agreement::Contract"
end
