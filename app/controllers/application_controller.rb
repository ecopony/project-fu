class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def load_project
    project_id_from_params = params[:project_id] ? params[:project_id] : params[:id]
    @project = Project.find(project_id_from_params)
  end

  def user_is_project_owner?
    unless current_user.is_a_owner_of?(@project)
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end

  def user_is_project_member?
    unless current_user.is_a_member_of?(@project)
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end
  
end
