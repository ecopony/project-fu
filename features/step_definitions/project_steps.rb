
Given /^the following projects exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:project, hash)
   end
end

Given /^there is a project named (.+)$/ do |project_name|
  @project = Factory.create(:project, :name => project_name)
end

Then /^the project should have a creator$/ do
  Project.first.creator.should_not be_nil
end

Then /^I should not see form fields for adding members$/ do
  page.should_not have_xpath("//div[@id='create_membership_form']")
end



