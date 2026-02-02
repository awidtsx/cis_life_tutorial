class Agreement::Eligibility < ApplicationRecord
  has_many :agreement_perils, foreign_key: :eligibility_id, class_name: "Agreement::Peril", dependent: :destroy
end
