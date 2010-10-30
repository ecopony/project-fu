class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :iterations_start_on
      t.date :project_start_date
      t.integer :iteration_length
      t.string :estimation_unit
      t.string :unit_scale
      t.integer :initial_velocity
      t.integer :velocity_strategy
      t.boolean :points_for_other_types
      t.boolean :allow_best_and_worst
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
