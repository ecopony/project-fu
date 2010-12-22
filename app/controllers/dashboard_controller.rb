class DashboardController < ApplicationController
  def index
    @projects = Project.all
  end
end
