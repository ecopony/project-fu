class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => 'creator_id'
  has_many :stories
  has_many :project_memberships
  has_many :project_members, :through => :project_memberships, :source => :user, :uniq => true

  validates :name, :presence => true

  validate :validate_unit_scale

  after_create :add_creator_as_owner

  attr_accessible :name,
                  :iterations_start_on,
                  :project_start_date,
                  :iteration_length,
                  :estimation_unit,
                  :unit_scale,
                  :initial_velocity,
                  :velocity_strategy,
                  :points_for_other_types,
                  :allow_best_and_worst,
                  :private

  class << self
    def all_for_user(user)
      return [] if user.nil?
      Project.joins(:project_memberships).where(["user_id = ?", user.id])
    end
  end

  def owners
    members_in_role('owner')
  end

  def view_only_members
    members_in_role('viewer')
  end

  def editors
    members_in_role(ProjectMembership.editor_roles)
  end

  def estimate_array
    unit_scale.strip.split(",").map { |estimate| Integer(estimate) }
  end

  def reorder_stories(ids)
    begin
      ids = ids.collect(&:to_s)
      stories.each do |story|
        story.position = ids.index(story.id.to_s) + 1
        story.save
      end
      return true
    rescue Exception => ex
      logger.error(ex)
      return false
    end
  end

  private

  def validate_unit_scale
    errors.add(:unit_scale, "can't be blank") and return if unit_scale.blank?
    errors.add(:unit_scale, "cannot contain a trailing comma") if unit_scale.strip.end_with?(",")
    scale_array = unit_scale.strip.split(",")
    errors.add(:unit_scale, "must be a comma-separated list of more than one number") if scale_array.size == 1
    validate_unit_scale_content(scale_array)
  end

  def validate_unit_scale_content(scale_array)
    begin
      scale_array.each do |item|
        Integer(item)
      end
    rescue
      errors.add(:unit_scale, "cannot include non-integers")
    end
  end

  def add_creator_as_owner
    project_memberships.create(:user => creator, :role => "owner") if creator
  end

  def members_in_role(role)
    project_members.where(:project_memberships => { :role => role })
  end

end
