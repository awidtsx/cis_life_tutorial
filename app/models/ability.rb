# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user.role.present?

    user.role.permissions.each do |permission|
      subject = constantize_subject(permission.subject)
      
      can :create, subject if permission.can_create
      can :read, subject if permission.can_read
      can :update, subject if permission.can_update
      can :destroy, subject if permission.can_delete
    end
  end

  private

  def constantize_subject(subject_name)
    # First try direct constantize (for subjects already in correct format like "Agreement::Contract")
    return subject_name.constantize
  rescue NameError
    # Handle namespaced models stored as snake_case
    # "agreement_contract" -> "Agreement::Contract"
    if subject_name.include?('_')
      parts = subject_name.split('_')
      
      # Try as namespace: agreement_contract -> Agreement::Contract
      namespace = parts[0].camelize
      model = parts[1..-1].join('_').camelize
      
      begin
        return "#{namespace}::#{model}".constantize
      rescue NameError
        # If namespace doesn't work, try as regular model
        # agreement_contract -> AgreementContract
        return subject_name.camelize.constantize
      end
    else
      # Simple case: no underscore, just camelize
      return subject_name.camelize.constantize
    end
  rescue NameError
    Rails.logger.warn "Could not constantize: #{subject_name}"
    subject_name.to_sym
  end
end