class ProjectMembershipsController < ApplicationController

  before_filter :load_project

  def index
    @project_membership = ProjectMembership.new
  end

  def create
    @project_membership = @project.project_memberships.build(params[:project_membership])

    if @project_membership.save
      flash[:notice] = "Successfully created project membership."
      redirect_to project_project_memberships_path(@project)
    else
      render :action => 'index'
    end    
  end

end
