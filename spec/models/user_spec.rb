require File.dirname(__FILE__) + '/../spec_helper'

describe User do

  describe "project-related methods" do
    before(:each) do
      @project = Factory.create(:project)
      @project_creator = @project.creator
      @project_member = Factory.create(:user)
      @project.project_memberships.create(:user => @project_member, :role => "member")
      @non_member = Factory.create(:user)
    end

    describe "project-membership eligibility" do

      it "should raise an error if it receives nil as an argument" do
        lambda { User.eligible_for_membership_to(nil) }.should raise_error(RuntimeError)
      end

      it "should raise an error if the object it recieves is not a project" do
        lambda { User.eligible_for_membership_to(Factory.create(:user)) }.should raise_error(RuntimeError)
      end

      it "return users not already a member of the project" do
        users = User.eligible_for_membership_to(@project)
        users.size.should == 1
        users.include?(@project_creator).should be_false
        users.include?(@project_member).should be_false
        users.include?(@non_member).should be_true
      end
    end

    describe "project ownership status" do

      it "should return true if the user is an owner of the project" do
        @project_creator.is_a_owner_of?(@project).should be_true
      end

      it "should return false if the user is not an owner of the project" do
        @project_member.is_a_owner_of?(@project).should be_false
        @non_member.is_a_owner_of?(@project).should be_false
      end
    end

    describe "project membership status" do

      it "should return true if the user is a member of the project" do
        @project_creator.is_a_member_of?(@project).should be_true
        @project_member.is_a_member_of?(@project).should be_true
      end

      it "should return false if the user is not a member of the project" do
        @non_member.is_a_member_of?(@project).should be_false       
      end

    end

  end

end
