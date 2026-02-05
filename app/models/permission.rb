class Permission < ApplicationRecord
  has_many :role_permissions
has_many :roles, through: :role_permissions
  ACTIONS = {
    read:   1,
    create: 2,
    update: 4,
    delete: 8
  }.freeze

  validates :subject, inclusion: { in: PermissionSubjects::SUBJECTS }

  def allow?(action)
    actions & ACTIONS[action] == ACTIONS[action]
  end

  def set_actions(action_keys)
    self.actions = action_keys.sum { |a| ACTIONS[a.to_sym] }
  end
end
