class Agreement::Rate < ApplicationRecord
    belongs_to :contract, class_name: "Agreement::Contract"
    has_many :insurance_contracts, as: :agreement
end
