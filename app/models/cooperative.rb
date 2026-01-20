class Cooperative < ApplicationRecord
  belongs_to :region, class_name: "AddRegion", foreign_key: "add_region_id", optional: true
  belongs_to :province, class_name: "AddProvince", foreign_key: "add_province_id", optional: true
  belongs_to :municipal, class_name: "AddMunicipal", foreign_key: "add_municipal_id", optional: true
  belongs_to :barangay, class_name: "AddBarangay", foreign_key: "add_barangay_id", optional: true

  has_many :contracts, as: :contractable, class_name: "Agreement::Contract"
end
