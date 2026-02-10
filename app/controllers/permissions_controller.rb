class PermissionsController < ApplicationController
  before_action :set_role

  def edit
    @permissions = @role.permissions.order(:subject)
  end

  def update
    if params[:permissions].present?
      params[:permissions].each do |permission_id, permission_params|
        permission = @role.permissions.find(permission_id)
        permission.update(
          can_create: permission_params[:can_create] == '1',
          can_read: permission_params[:can_read] == '1',
          can_update: permission_params[:can_update] == '1',
          can_delete: permission_params[:can_delete] == '1'
        )
      end
      redirect_to roles_path, notice: 'Permissions updated successfully.'
    else
      redirect_to edit_role_permissions_path(@role), alert: 'No permissions to update.'
    end
  end

  private

  def set_role
    @role = Role.find(params[:role_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to roles_path, alert: 'Role not found.'
  end
end