class Story < ActiveRecord::Base

  STANDARD_DEVIATION_DEVISOR = 2.0

  belongs_to :project
  belongs_to :requested_by, :class_name => 'User', :foreign_key => 'requested_by_id'
  belongs_to :owned_by, :class_name => 'User', :foreign_key => 'owned_by_id'

  validates :project_id, :presence => true
  validates :title, :presence => true
  validates :requested_by_id, :presence => true
  validates :story_type, :presence => true
  validates :state, :presence => true

  before_save :story_math_fu

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

  def story_math_fu
    if set_best_and_worst_case
      set_expected_case
      set_deviation
      set_variance
    end
  end

  def set_best_and_worst_case
    return false if estimate.blank?
    estimate_array = estimate.to_s.strip.split("-")
    errors.add(:estimate, "cannot include more than two numbers for a range") and return false if estimate_array.size > 2
    estimate_array = estimate_array.size == 1 ? [estimate_array.first, estimate_array.first] : [estimate_array.first, estimate_array.second]

    begin
      estimate_array.collect! { |item| Float(item) }
      self.best_case_estimate, self.worst_case_estimate = estimate_array
      return true
    rescue
      errors.add(:estimate, "cannot include non-integers")
      return false
    end
  end

  def set_expected_case
    self.expected_case_estimate = (best_case_estimate + worst_case_estimate).to_f / 2
  end

  def set_deviation
    self.estimate_deviation = (worst_case_estimate - best_case_estimate) / STANDARD_DEVIATION_DEVISOR
  end

  def set_variance
    self.estimate_variance = estimate_deviation**2
  end

  def non_view_only_member?(user)
    !project.view_only_members.include?(user)
  end

end
