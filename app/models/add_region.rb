class AddRegion < ApplicationRecord
      has_many :cooperatives, foreign_key: "add_region_id"
end
