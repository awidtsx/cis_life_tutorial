class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to auth_index_path # or auth_index_path if you have that route
  end
  
  def create
    super
  end
  
  protected
  
  def after_sign_in_path_for(resource)
    dashboard_path # or wherever you want users to go after sign in
  end
end