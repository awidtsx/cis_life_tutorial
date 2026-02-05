class RolePermissionsController < ApplicationController
  def edit
  @role = Role.find(params[:role_id])
  @roles = Role.all

  @permissions_by_subject =
    @role.permission.index_by(&:subject)

  end

  def update
   @role = Role.find(params[:role_id])

  @role.permission_ids = params[:permission_ids] || []

  redirect_to edit_role_permission_path(role_id: @role.id),
              notice: "Permissions updated"
  end

  def update_permissions
  role = Role.find(params[:role_id])

  params[:permission].each do |subject, actions|
    permission = Permission.find_or_initialize_by(subject: subject)
    permission.set_actions(actions || [])
    permission.save!

    RolePermission.find_or_create_by!(
      role: role,
      permission: permission
    )
  end

  redirect_to role_path(role), notice: "Permissions updated"
  end
end
