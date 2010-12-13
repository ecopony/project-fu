require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid" do
    Project.new.should be_valid
  end

  describe "during creation" do
    it "should make the creator an owner" do
      project = Factory.create(:project)
      project.project_members.first.should == project.creator
      project.project_memberships.first.role.should == "owner"
    end
  end
end
