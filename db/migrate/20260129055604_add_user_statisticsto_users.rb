class AddUserStatisticstoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :active, :boolean
    add_column :users, :signin, :integer
  end
end
