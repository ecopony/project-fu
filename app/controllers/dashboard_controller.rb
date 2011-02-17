class DashboardController < ApplicationController
  def index
    @projects = Project.all_for_user(current_user)
  end
end
