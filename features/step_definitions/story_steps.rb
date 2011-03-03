
Given /^the following stories exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:story, hash.merge!( :project => @project ))
   end
end

Then /^the requested by user should be the current user$/ do
  page.should have_content("Requested By: #{@user.login}")
end

