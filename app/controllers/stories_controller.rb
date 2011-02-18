class StoriesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :load_project
  before_filter :user_is_project_member?
  
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
    if @story.update_attributes(params[:story])
      flash[:notice] = "Successfully updated story."
      redirect_to project_story_url(@project, @story)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:notice] = "Successfully destroyed story."
    redirect_to project_stories_url(@project)
  end

end
