class CreateInsuranceProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_products do |t|
      t.string :name
      t.string :description
      t.string :product_type

      t.timestamps
    end
  end
end
