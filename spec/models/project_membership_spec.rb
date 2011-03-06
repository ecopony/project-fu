require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectMembership do

  before(:each) do
    @valid_attributes = {
        :project => Factory.create(:project),
        :user => Factory.create(:user),
        :role => "member"
    }
  end

  it "should be valid" do
    ProjectMembership.new(@valid_attributes).should be_valid
  end

  it "should be invalid without a project" do
    attributes = @valid_attributes.reject { |key, value| key == :project }
    project_membership = ProjectMembership.new(attributes)
    project_membership.should_not be_valid
    project_membership.errors[:project_id].include?("can't be blank").should be_true
  end

  it "should be invalid without a user" do
    attributes = @valid_attributes.reject { |key, value| key == :user }
    project_membership = ProjectMembership.new(attributes)
    project_membership.should_not be_valid
    project_membership.errors[:user_id].include?("can't be blank").should be_true
  end

  it "should be invalid without a role" do
    attributes = @valid_attributes.reject { |key, value| key == :role }
    project_membership = ProjectMembership.new(attributes)
    project_membership.should_not be_valid
    project_membership.errors[:role].include?("can't be blank").should be_true
  end

  it "should be valid with a valid role of 'member'" do
    @valid_attributes.merge(:role => 'member')
    ProjectMembership.new(@valid_attributes).should be_valid
  end

  it "should be valid with a valid role of 'owner'" do
    @valid_attributes.merge(:role => 'owner')
    ProjectMembership.new(@valid_attributes).should be_valid
  end

  it "should be valid with a valid role of 'viewer'" do
    attributes = @valid_attributes.merge(:role => 'viewer')
    ProjectMembership.new(attributes).should be_valid
  end

  it "should not be valid with an unknown role" do
    attributes = @valid_attributes.merge(:role => 'lackey')
    ProjectMembership.new(attributes).should_not be_valid
  end

  it "should display a meaningful error message when the role is not valid" do
    attributes = @valid_attributes.merge(:role => 'lackey')
    project_membership = ProjectMembership.create(attributes)
    project_membership.errors[:role].include?("is not valid").should be_true
  end

  describe "project membership roles" do

    it "should return an array of roles for drop downs" do
      ProjectMembership.role_array.class.name.should == "Array"
    end

    it "should return the two project roles" do
      roles = ProjectMembership.role_array
      roles.size.should == 3
    end

  end

end
