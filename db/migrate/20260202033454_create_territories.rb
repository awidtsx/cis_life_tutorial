class CreateTerritories < ActiveRecord::Migration[7.1]
  def change
    create_table :territories do |t|
      t.string :name

      t.timestamps
    end
  end
end
