class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:show, :edit, :update, :destroy, :settings]
  before_filter :user_is_project_member?, :only => [:show]
  before_filter :user_is_project_owner?, :only => [:edit, :update, :destroy, :settings]

  def index
    @projects = Project.all_for_user(current_user)
  end
  
  def show
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.creator = current_user
    
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end

  def settings
  end
end
