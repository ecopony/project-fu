require 'factory_girl'

Factory.define :project do |p|
  p.name { Factory.next(:project_name) }
end

#
# Sequences
#

Factory.sequence :project_name do |n|
  "project_#{n}"
end
