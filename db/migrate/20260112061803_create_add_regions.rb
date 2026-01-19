class CreateAddRegions < ActiveRecord::Migration[7.1]
  def change
    create_table :add_regions do |t|
      t.string :name

      t.timestamps
    end
  end
end
