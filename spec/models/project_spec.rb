require File.dirname(__FILE__) + '/../spec_helper'

describe Project do

  before(:each) do
    @valid_attributes = {
      :name => "Project name",
      :unit_scale => "0, 1, 2, 3, 5, 8, 13, 20, 40, 100"
    }
  end

  it "should be valid" do
    Project.new(@valid_attributes).should be_valid
  end

  it "should be invalid without a name" do
    project = Project.new
    project.should_not be_valid
    project.errors[:name].include?("can't be blank").should be_true
  end

  describe "validating unit scale" do
    before(:each) do
      @modified_attributes = @valid_attributes.reject { |key, value| key == :unit_scale }
    end

    it "should not be valid if blank" do
      Project.new(@modified_attributes).should_not be_valid
    end

    it "should be valid with a comma-separated list" do
      project = Project.new(@modified_attributes)
      project.unit_scale = "0, 1, 2, 3, 5, 8, 13, 20, 40, 100"
      project.should be_valid
    end

    it "should not be valid with a semi-colon separated list" do
      project = Project.new(@modified_attributes)
      project.unit_scale = "0; 1; 2; 3; 5; 8; 13; 20; 40; 100"
      project.should_not be_valid
    end

    it "should not be valid if no comma is present" do
      project = Project.new(@modified_attributes)
      project.unit_scale = "0 1 2 3 5 8 13 20 40 100"
      project.should_not be_valid
    end

    it "should not be valid if any of the values are not an integer" do
      project = Project.new(@modified_attributes)
      project.unit_scale = "0, A, 2, 3, 5, 8, 13, 20, 40, 100"
      project.should_not be_valid
    end

    it "should not be valid if there is a trailing comma" do
      project = Project.new(@modified_attributes)
      project.unit_scale = "0, 1, 2, 3, 5, 8, 13, 20, 40, 100,"
      project.should_not be_valid
    end

  end

  describe "during creation" do
    it "should make the creator an owner" do
      project = Factory.create(:project)
      project.project_members.first.should == project.creator
      project.project_memberships.first.role.should == "owner"
    end
  end

  describe "retrieving project owners" do

    before(:each) do
      @project = Factory.create(:project)
      @project_creator = @project.creator
      @project_member = Factory.create(:user)
      @project_owner = Factory.create(:user)
      @project.project_memberships.create(:user => @project_owner, :role => "owner")
      @project.project_memberships.create(:user => @project_member, :role => "member")
      @non_member = Factory.create(:user)
    end

    it "should return the creator of a project" do
      @project.owners.include?(@project_creator).should be_true
    end

    it "should return an owner of the project" do
      @project.owners.include?(@project_owner).should be_true
    end

    it "should not return a regular member of the project" do
      @project.owners.include?(@project_member).should be_false
    end

    it "should not return a non-member of the project" do
      @project.owners.include?(@non_member).should be_false
    end

  end

  describe "retrieving a user's projects" do

    before(:each) do
      @member = Factory.create(:user)
      @non_member = Factory.create(:user)
      @another_project = Factory.create(:project)
      2.times { Factory.create(:project).project_memberships.create(:user => @member, :role => 'member') }
    end

    it "should return all projects to which the user belongs" do
      Project.all_for_user(@member).size.should == 2
    end

    it "should return an empty array if the user doesn't belong to any projects" do
      Project.all_for_user(@non_member).should be_empty
    end

    it "should return an empty array if passed nil" do
      Project.all_for_user(nil).should be_empty
    end

  end

  describe "returning an estimate array" do
    it "should return an array of valid estimates" do
      project = Project.new(@valid_attributes)
      project.estimate_array.is_a?(Array).should be_true
      project.estimate_array.each { |estimate| estimate.is_a?(Integer).should be_true }
    end
  end

  describe "reordering" do

    before(:each) do
      @project = Factory.create(:project)
      @story_one = Factory.create(:story, :project => @project, :position => 1)
      @story_two = Factory.create(:story, :project => @project, :position => 2)
    end

    it "should reorder into the order of the ids provided" do
      @project.reorder_stories([@story_two.id.to_s, @story_one.id.to_s])
      @story_one.reload.position.should == 2
      @story_two.reload.position.should == 1
    end

    it "should reorder when provided integers instead of strings" do
      @project.reorder_stories([@story_two.id, @story_one.id])
      @story_one.reload.position.should == 2
      @story_two.reload.position.should == 1
    end

    it "should return true when successful" do
      @project.reorder_stories([@story_two.id.to_s, @story_one.id.to_s]).should be_true
    end

    it "should return false when it fails" do
      @project.reorder_stories(nil).should be_false
    end

  end

end
