class Agreement::Peril < ApplicationRecord
  belongs_to :agreement_eligibility,
             class_name: "Agreement::Eligibility",
             foreign_key: :eligibility_id
end
