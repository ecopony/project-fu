
Given /^the following stories exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:story, hash.merge!( :project => @project ))
   end
end

Given /^there is a story titled (.+)$/ do |story_title|
  @story = Factory.create(:story, :title => story_title)
end

Then /^the requested by user should be the current user$/ do
  page.should have_content("Requested By: #{@user.login}")
end

Then /^the story ID should be visible$/ do
  page.should have_content("ID")
  page.should have_content(@story.id.to_s)
end

