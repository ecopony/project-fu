require File.dirname(__FILE__) + '/../spec_helper'

describe Story do
  before(:each) do
    @project = Factory.create(:project)

    @valid_attributes = {
      :title => "A user can login",
      :story_type => "story",
      :state => "unstarted",
      :requested_by_id => Factory.create(:user).id
    }
  end

  it "should be valid" do
    story = Story.new(@valid_attributes)
    story.project_id = @project.id
    story.should be_valid
  end

  it "should be invalid without a project" do
    story = Story.new(@valid_attributes)
    story.should_not be_valid
    story.errors_on(:project_id).include?("can't be blank").should be_true
  end

  it "should be invalid without a title" do
    attributes = @valid_attributes.reject { |key, value| key == :title }
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
    story.errors_on(:title).include?("can't be blank").should be_true
  end

  it "should be invalid without a story type" do
    attributes = @valid_attributes.reject { |key, value| key == :story_type }
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
    story.errors_on(:story_type).include?("can't be blank").should be_true
  end

  it "should be invalid without a state" do
    attributes = @valid_attributes.reject { |key, value| key == :state }
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
    story.errors_on(:state).include?("can't be blank").should be_true
  end

  it "should be invalid without a requested by" do
    attributes = @valid_attributes.reject { |key, value| key == :requested_by_id }
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
    story.errors_on(:requested_by_id).include?("can't be blank").should be_true
  end

  it "should be valid with a valid story type" do
    Story.valid_story_types.each do |story_type|
      attributes = @valid_attributes.merge(:story_type => story_type)
      story = Story.new(attributes)
      story.project_id = @project.id
      story.should be_valid
    end
  end

  it "should be invalid with an invalid story type" do
    attributes = @valid_attributes.merge(:story_type => 'use case')
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
  end

  it "should be valid with a valid state" do
    Story.valid_states.each do |state|
      attributes = @valid_attributes.merge(:state => state)
      story = Story.new(attributes)
      story.project_id = @project.id
      story.should be_valid
    end
  end

  it "should be invalid with an invalid state" do
    attributes = @valid_attributes.merge(:state => 'stuck')
    story = Story.new(attributes)
    story.project_id = @project.id
    story.should_not be_valid
  end

  describe "determining permissible actions" do

    before(:each) do
      @project = Factory.create(:project)
      @project_member = Factory.create(:user)
      @project_owner = Factory.create(:user)
      @project_viewer = Factory.create(:user)

      @project.project_memberships.create(:user => @project_owner, :role => "owner")
      @project.project_memberships.create(:user => @project_member, :role => "member")
      @project.project_memberships.create(:user => @project_viewer, :role => "viewer")

      @story = Factory.create(:story, :project => @project)
    end

    it "should let owners and members edit, destroy, and work it" do
      [@project_owner, @project_member].each do |user|
        @story.editable_by?(user).should be_true
        @story.destructible_by?(user).should be_true
        @story.workable_by?(user).should be_true
      end
    end

    it "should not let viewers edit, destroy, or work it" do
      [@project_viewer].each do |user|
        @story.editable_by?(user).should be_false
        @story.destructible_by?(user).should be_false
        @story.workable_by?(user).should be_false
      end
    end

  end
end
