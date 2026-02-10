class Role < ApplicationRecord

  has_many :permissions, dependent: :destroy
  has_many :users
  after_create :create_default_permissions
  
  private
  
  def create_default_permissions
   default_subjects = [
  'insurance_contract',
  'insurance_group',
  'agreement_peril',
  'insurance_product',
  'agreement_contract',
  'agreement_rate',
  'agreement_eligibility',
  'producer',
  'permission',
  'role',
  'address',
  'coop_membership',
  'registry',
  'branch',
  'employee',
  'type',
  'individual',
  'dependent',
  'relationship',
  'department',
  'branch_office',
  'territory',
  'add_region',
  'add_province',
  'add_municipal',
  'add_barangay',
  'cooperative'  
    ]
    
    default_subjects.each do |subject_name|
      permissions.create(subject: subject_name)
    end
  end

end
