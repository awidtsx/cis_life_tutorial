class CreateBranchOffices < ActiveRecord::Migration[7.1]
  def change
    create_table :branch_offices do |t|
      t.string :name
      t.references :territory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
