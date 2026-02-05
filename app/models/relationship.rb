class Relationship < ApplicationRecord
  belongs_to :agreement, polymorphic: true
end
