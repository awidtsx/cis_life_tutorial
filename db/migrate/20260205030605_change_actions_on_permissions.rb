class ChangeActionsOnPermissions < ActiveRecord::Migration[7.1]
  def change
    change_column_default :permissions, :action, 0
    change_column_null :permissions, :action, false, 0
  end
end
