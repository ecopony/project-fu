class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => 'creator_id'
  has_many :stories
  has_many :project_memberships
  has_many :project_members, :through => :project_memberships, :source => :user, :uniq => true

  validates :name, :presence => true

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

  private

  def add_creator_as_owner
    project_memberships.create(:user => creator, :role => "owner") if creator
  end

  def members_in_role(role)
    project_members.where(:project_memberships => { :role => role })
  end

end
