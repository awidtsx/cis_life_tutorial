class ConvertRelationshipsToPolymorphic < ActiveRecord::Migration[7.1]
  def up
    # Add polymorphic columns
    add_column :relationships, :agreement_type, :string
    add_column :relationships, :agreement_id, :integer
    
    # Copy existing data if you have contract_id
    # Uncomment these lines if you want to migrate existing data:
    # Relationship.reset_column_information
    # Relationship.where.not(contract_id: nil).find_each do |relationship|
    #   relationship.update_columns(
    #     agreement_type: 'Agreement::Contract',
    #     agreement_id: relationship.contract_id
    #   )
    # end
    
    # Remove old foreign key and column
    remove_column :relationships, :contract_id, :integer
    
    # Add indexes for better performance
    add_index :relationships, [:agreement_type, :agreement_id]
  end

  def down
    # Add back the old column
    add_column :relationships, :contract_id, :integer
    
    # Copy data back if needed
    # Uncomment these lines if you want to rollback with data:
    # Relationship.reset_column_information
    # Relationship.where(agreement_type: 'Agreement::Contract').find_each do |relationship|
    #   relationship.update_columns(contract_id: relationship.agreement_id)
    # end
    
    # Remove polymorphic columns
    remove_index :relationships, [:agreement_type, :agreement_id]
    remove_column :relationships, :agreement_type
    remove_column :relationships, :agreement_id
  end
end
