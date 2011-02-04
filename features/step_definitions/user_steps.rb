Given /^the following users exist$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:user, hash)
   end
end