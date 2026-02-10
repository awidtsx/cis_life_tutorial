class RenamePermissionColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :permissions, :create, :can_create
    rename_column :permissions, :read, :can_read
    rename_column :permissions, :update, :can_update
    rename_column :permissions, :delete, :can_delete
  end
end
