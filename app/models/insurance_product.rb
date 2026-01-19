class InsuranceProduct < ApplicationRecord
      enum product_type: {
    individual: "Individual",
    group_policy: "Group"
  }
end
