class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :designation, :string, null: true
    add_column :users, :gender, :string
    add_reference :users, :branch, null: true, foreign_key: true
    add_reference :users, :cooperative, null: true, foreign_key: true
    add_reference :users, :department, null: true, foreign_key: true
  end
end
