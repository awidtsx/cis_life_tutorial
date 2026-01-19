class CreateAddProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :add_provinces do |t|
      t.string :name
      t.references :add_region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
