class CreateCoopMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :coop_memberships do |t|
      t.references :cooperative, null: false, foreign_key: true
      t.references :individual, null: false, foreign_key: true
      t.date :membership_date

      t.timestamps
    end
  end
end
