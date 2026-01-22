class InsuranceGroup < ApplicationRecord
  # Associations
  belongs_to :cooperative
  belongs_to :contract, class_name: "Agreement::Contract"
  belongs_to :insurance_contract, optional: true
  
  # Get all member contracts for this insurance group
  # These are contracts where insured is a CoopMembership belonging to this cooperative
  def member_contracts
    member_ids = cooperative.coop_memberships.pluck(:id)
    InsuranceContract.where(
      insured_type: 'CoopMembership',
      insured_id: member_ids,
      agreement_type: 'Agreement::Rate'
    ).where(
      agreement_id: contract.agreement_rates.pluck(:id)
    )
  end
  
  # Get members who already have contracts
  def insured_members
    member_contracts.includes(:insured).map(&:insured)
  end
  
  # Get members who don't have contracts yet
  def uninsured_members
    insured_ids = insured_members.map(&:id)
    cooperative.coop_memberships.where.not(id: insured_ids)
  end
  
  # Validations
  validates :cooperative_id, presence: true
  validates :contract_id, presence: true
  
  # Ensure the contract matches the cooperative
  validate :contract_matches_cooperative
  
  private
  
  def contract_matches_cooperative
    return unless contract && cooperative
    
    if contract.contractable_type == 'Cooperative' && contract.contractable_id != cooperative_id
      errors.add(:contract_id, "must be associated with the selected cooperative")
    end
  end
end