class CreateAddBarangays < ActiveRecord::Migration[7.1]
  def change
    create_table :add_barangays do |t|
      t.string :name
      t.references :add_municipal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
