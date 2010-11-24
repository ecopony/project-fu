class Story < ActiveRecord::Base
  validates :title, :presence => true

  attr_accessible :title, :story_type, :estimate, :owned_by_id, :description
end
