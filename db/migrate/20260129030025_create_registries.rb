class CreateRegistries < ActiveRecord::Migration[7.1]
  def change
    create_table :registries do |t|
      t.string :name
      t.references :cooperative, null: false, foreign_key: true

      t.timestamps
    end
  end
end
