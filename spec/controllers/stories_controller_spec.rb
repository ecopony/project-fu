require File.dirname(__FILE__) + '/../spec_helper'

describe StoriesController do

  describe "Ajax errors" do

    before(:each) do
      login
      @current_user.expects(:is_an_editor_of?).returns(true)
      @project = Factory.create(:project)
      @story_one = Factory.create(:story, :project => @project, :position => 1)
      @story_two = Factory.create(:story, :project => @project, :position => 2)
    end

    it "should return the Ajax error message when an error occurs during reordering" do
      xhr :put, :reorder, :project_id => @project.id, :stories => [nil]
      response.should render_template('_ajax_error')
    end

    it "should return the Ajax error message when an error occurs during state changes" do
      xhr :put, :update, :project_id => @project.id, :id => @story_one.id, :story => { :state => 'stuck' }
      response.should render_template('_ajax_error')
    end

  end

end