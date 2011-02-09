class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def user_is_project_owner?
    unless current_user.is_a_owner_of?(@project)
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end
  
end
