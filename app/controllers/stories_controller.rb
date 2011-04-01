class StoriesController < ApplicationController

  before_filter :require_user
  before_filter :load_project
  before_filter :user_can_view_project?, :only => [:index, :show]
  before_filter :user_can_edit_project?, :except => [:index, :show]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])
    @story.project_id = @project.id

    if @story.save
      flash[:notice] = "Successfully created story."
      redirect_to project_story_url(@project, @story)
    else
      render :action => 'new'
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = "Successfully updated story."
        format.html { redirect_to project_story_url(@project, @story) }
        format.js {}
      else
        format.html { render :action => 'edit' }
        format.js { render :partial => '/ajax_error', :locals => { :message => "Story could not be updated." } }
      end
    end

  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:notice] = "Successfully destroyed story."
    redirect_to project_stories_url(@project)
  end

  def reorder
    respond_to do |format|
      format.js do
        if @project.reorder_stories(params['stories'])
          render :nothing => true
        else
          render :partial => '/ajax_error', :locals => { :message => "Error reordering stories." }
        end
      end
    end

  end

end
