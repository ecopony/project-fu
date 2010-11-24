
Given /^the following stories exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:story, hash)
   end
end

