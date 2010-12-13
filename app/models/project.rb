class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => 'creator_id'
  has_many :project_memberships
  has_many :project_members, :through => :project_memberships, :source => :user, :uniq => true

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
    :allow_best_and_worst

  private

  def add_creator_as_owner
    project_memberships.create(:user => creator, :role => "owner") if creator
  end
  
end
