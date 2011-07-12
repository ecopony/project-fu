class AddFuFieldsToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :best_case_estimate, :integer
    add_column :stories, :worst_case_estimate, :integer
    add_column :stories, :expected_case_estimate, :float
    add_column :stories, :estimate_deviation, :float
    add_column :stories, :estimate_variance, :float

    change_column :stories, :estimate, :string
  end

  def self.down
    change_column :stories, :estimate, :integer

    remove_column :stories, :best_case_estimate
    remove_column :stories, :worst_case_estimate
    remove_column :stories, :expected_case_estimate
    remove_column :stories, :estimate_deviation
    remove_column :stories, :estimate_variance
  end
end
