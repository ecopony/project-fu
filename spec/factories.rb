require 'factory_girl'

Factory.define :project do |p|
  p.name { Factory.next(:project_name) }
  p.creator { Factory.create(:user) }
end

Factory.define :story do |s|
  s.title { Factory.next(:title) }
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.password "password"
  u.password_confirmation "password"
end

#
# Sequences
#

Factory.sequence :email do |n|
  "username@testuser#{n}.com"
end

Factory.sequence :project_name do |n|
  "project_#{n}"
end

Factory.sequence :title do |n|
  "A user can do something #{n} times"
end
