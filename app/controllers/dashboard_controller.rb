class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @certificate_overview = InsuranceContract.dashboard_overview
    @user = current_user
  end
end
