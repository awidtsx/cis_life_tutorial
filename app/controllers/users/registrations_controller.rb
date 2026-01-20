class Users::RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to root_path # or auth_index_path
  end
  
  def create
    super
  end
  
  protected
  
  def after_sign_up_path_for(resource)
    dashboard_path # or wherever you want users to go after sign up
  end
end