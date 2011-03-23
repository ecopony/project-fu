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

  def reorder
    @project.stories.each do |story|
      story.position = params['stories'].index(story.id.to_s) + 1
      story.save
    end
    render :nothing => true
  end

end
