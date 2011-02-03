class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
