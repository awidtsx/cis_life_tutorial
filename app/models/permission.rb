class Permission < ApplicationRecord
  belongs_to :role
  
  validates :subject, presence: true
  validates :subject, uniqueness: { scope: :role_id }
end
