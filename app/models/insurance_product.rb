class InsuranceProduct < ApplicationRecord
      enum product_type: {
    individual: "individual",
    group_policy: "group_policy"
  }
end
