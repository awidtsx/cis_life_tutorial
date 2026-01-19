class AddMunicipal < ApplicationRecord
  belongs_to :add_province
    has_many :cooperatives, foreign_key: "add_municipal_id"
end
