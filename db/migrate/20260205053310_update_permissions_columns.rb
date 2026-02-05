class UpdatePermissionsColumns < ActiveRecord::Migration[7.1]
  def change
    
    remove_column :permissions, :action, :string

    
    add_column :permissions, :create, :boolean, default: false, null: false
    add_column :permissions, :read,   :boolean, default: false, null: false
    add_column :permissions, :update, :boolean, default: false, null: false
    add_column :permissions, :delete, :boolean, default: false, null: false
  end
end
