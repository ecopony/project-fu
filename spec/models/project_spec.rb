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
end
