class CreateDependents < ActiveRecord::Migration[7.1]
  def change
    create_table :dependents do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.date :birthdate
      t.string :gender
      t.references :relationship, null: false, foreign_key: true
      t.references :individual, null: false, foreign_key: true

      t.timestamps
    end
  end
end
