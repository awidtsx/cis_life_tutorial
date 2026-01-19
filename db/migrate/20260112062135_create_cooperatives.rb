class CreateCooperatives < ActiveRecord::Migration[7.1]
  def change
    create_table :cooperatives do |t|
      t.string :name
      t.references :add_region, null: false, foreign_key: true
      t.references :add_province, null: false, foreign_key: true
      t.references :add_municipal, null: false, foreign_key: true
      t.references :add_barangay, null: false, foreign_key: true

      t.timestamps
    end
  end
end
