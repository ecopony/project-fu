
Given /^the following projects exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:project, hash)
  end
end

Given /^there is a project named (.+)$/ do |project_name|
  @project = Factory.create(:project, :name => project_name)
end

Given /^I am a (.*) of project "([^"]*)"$/ do |role, project_name|
  project = Project.find_by_name(project_name)
  project.project_memberships << ProjectMembership.create(:user => @user, :role => role)
end

Given /^there is a project member with the login "([^"]*)"$/ do |login|
  @project_member = Factory.create(:user,
                                   :login => login,
                                   :password => "user_password",
                                   :password_confirmation => "user_password"
  )

  @project.project_memberships << ProjectMembership.create(:user => @project_member, :role => 'member')
end


Then /^the project should have a creator$/ do
  Project.first.creator.should_not be_nil
end

Then /^I should not see form fields for adding members$/ do
  page.should_not have_xpath("//div[@id='create_membership_form']")
end




