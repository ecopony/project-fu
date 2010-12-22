
Given /^the following stories exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:story, hash.merge!( :project => @project ))
   end
end

