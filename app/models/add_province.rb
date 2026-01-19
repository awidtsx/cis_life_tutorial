class AddProvince < ApplicationRecord
  belongs_to :add_region
    has_many :cooperatives, foreign_key: "add_province_id"
end
