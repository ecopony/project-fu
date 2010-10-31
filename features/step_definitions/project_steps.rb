
Given /^the following projects exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:project, hash)
   end
end

