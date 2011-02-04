require File.dirname(__FILE__) + '/../spec_helper'

describe Project do

  before(:each) do
    @valid_attributes = {
        :name => "Project name"
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

end
