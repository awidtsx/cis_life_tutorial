class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.string :relationship
      t.references :contract, null: false, foreign_key: { to_table: :agreement_contracts }

      t.timestamps
    end
  end
end
