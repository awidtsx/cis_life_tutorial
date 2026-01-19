class CreateIndividuals < ActiveRecord::Migration[7.1]
  def change
    create_table :individuals do |t|
      t.string :last_name
      t.string :first_name
      t.string :mi
      t.date :birth_date
      t.string :gender

      t.timestamps
    end
  end
end
