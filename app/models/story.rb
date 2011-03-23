class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :requested_by, :class_name => "User", :foreign_key => 'requested_by_id'
  belongs_to :owned_by, :class_name => "User", :foreign_key => 'owned_by_id'

  validates :project_id, :presence => true
  validates :title, :presence => true
  validates :requested_by_id, :presence => true
  validates :story_type, :presence => true

  acts_as_list :scope => :project
  default_scope order('position ASC')

  class << self
    def story_type_array
      [
          ["Story", "story"],
          ["Epic", "epic"],
          ["Chore", "chore"],
          ["Defect", "defect"],
          ["Dive", "dive"]
      ]
    end

    def valid_story_types
      @valid_story_types ||= story_type_array.map { |story_type| story_type.last }
    end
  end

  validates_inclusion_of :story_type, :in => self.valid_story_types, :message => "is not valid"

  attr_accessible :title, :story_type, :estimate, :owned_by_id, :requested_by_id, :description
  
  def editable_by?(user)
    !project.view_only_members.include?(user)
  end

  def destructible_by?(user)
    !project.view_only_members.include?(user)
  end

end
