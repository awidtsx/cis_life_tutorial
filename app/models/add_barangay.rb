class AddBarangay < ApplicationRecord
  belongs_to :add_municipal
  has_many :cooperatives, foreign_key: "add_barangay_id"
end
