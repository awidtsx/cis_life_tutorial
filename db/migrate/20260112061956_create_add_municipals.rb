class CreateAddMunicipals < ActiveRecord::Migration[7.1]
  def change
    create_table :add_municipals do |t|
      t.string :name
      t.references :add_province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
