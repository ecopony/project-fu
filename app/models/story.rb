class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :requested_by, :class_name => "User", :foreign_key => 'requested_by_id'

  validates :title, :presence => true
  validates :requested_by_id, :presence => true
  validates :story_type, :presence => true

  attr_accessible :title, :story_type, :estimate, :owned_by_id, :requested_by_id, :description
end
