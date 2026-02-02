class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


protected


def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: [
:first_name,
:last_name,
:birthdate,
:gender,
:designation,
:branch_id,
:cooperative_id,
:department_id
])


devise_parameter_sanitizer.permit(:account_update, keys: [
:first_name,
:last_name,
:birthdate,
:gender,
:designation,
:branch_id,
:cooperative_id,
:department_id,
:active,
:signin,
:role
])
end
end
