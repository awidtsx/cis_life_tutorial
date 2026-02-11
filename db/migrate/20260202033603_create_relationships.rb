class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.string :relationship
      t.references :agreement, polymorphic: true, null: false

      t.timestamps
    end
  end
end
