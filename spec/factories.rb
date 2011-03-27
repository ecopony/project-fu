require 'factory_girl'

Factory.define :project do |p|
  p.name { Factory.next(:project_name) }
  p.unit_scale "0, 1, 2, 3, 5, 8, 13, 20, 40, 100"
  p.creator { Factory.create(:user) }
end

Factory.define :story do |s|
  s.title { Factory.next(:title) }
  s.story_type "story"
  s.state "unstarted"
  s.requested_by { Factory.create(:user) }
  s.association :project
end

Factory.define :user do |u|
  u.login { Factory.next(:login) }
  u.email { Factory.next(:email) }
  u.password "password"
  u.password_confirmation "password"
end

#
# Sequences
#

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :email do |n|
  "username@testuser#{n}.com"
end

Factory.sequence :project_name do |n|
  "project_#{n}"
end

Factory.sequence :title do |n|
  "A user can do something #{n} times"
end
