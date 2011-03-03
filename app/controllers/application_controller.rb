class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user

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

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
