class Story < ActiveRecord::Base
  belongs_to :project
  validates :title, :presence => true

  attr_accessible :title, :story_type, :estimate, :owned_by_id, :description
end
