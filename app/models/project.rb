class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => 'creator_id'
  
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
end
