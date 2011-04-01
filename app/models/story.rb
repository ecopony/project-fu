class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :requested_by, :class_name => 'User', :foreign_key => 'requested_by_id'
  belongs_to :owned_by, :class_name => 'User', :foreign_key => 'owned_by_id'

  validates :project_id, :presence => true
  validates :title, :presence => true
  validates :requested_by_id, :presence => true
  validates :story_type, :presence => true
  validates :state, :presence => true

  acts_as_list :scope => :project_id

  class << self
    def story_type_array
      [
        ['Story', 'story'],
        ['Epic', 'epic'],
        ['Chore', 'chore'],
        ['Defect', 'defect'],
        ['Dive', 'dive']
      ]
    end

    def valid_story_types
      @valid_story_types ||= story_type_array.map { |story_type| story_type.last }
    end

    def state_array
      [
        ['Not Yet Started', 'unstarted'],
        ['Started', 'started'],
        ['Finished', 'finished'],
        ['Accepted', 'accepted'],
        ['Rejected', 'rejected']
      ]
    end

    def valid_states
      @valid_states ||= state_array.map { |state| state.last }
    end
  end

  validates_inclusion_of :story_type, :in => self.valid_story_types, :message => 'is not valid'
  validates_inclusion_of :state, :in => self.valid_states, :message => 'is not valid'
  
  attr_accessible :title, :story_type, :estimate, :owned_by_id, :requested_by_id, :description, :state

  def workable_by?(user)
    non_view_only_member?(user)
  end

  def editable_by?(user)
    non_view_only_member?(user)
  end

  def destructible_by?(user)
    non_view_only_member?(user)
  end

  private

  def non_view_only_member?(user)
    !project.view_only_members.include?(user)
  end

end
