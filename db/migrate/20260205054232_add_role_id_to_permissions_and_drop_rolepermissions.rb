class AddRoleIdToPermissionsAndDropRolepermissions < ActiveRecord::Migration[7.1]
  def change
  def up
    # Add role_id to permissions table
    add_reference :permissions, :role, null: false, foreign_key: true
    
    # Drop the rolepermissions join table
    drop_table :rolepermissions
  end


  end
end
