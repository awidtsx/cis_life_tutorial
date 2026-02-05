class Permission < ApplicationRecord
  belongs_to :role
  
  validates :subject, inclusion: { in: PermissionSubjects::SUBJECTS }
  validates :subject, uniqueness: { scope: :role_id }
end
