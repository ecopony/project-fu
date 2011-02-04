class AddCreatorToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :creator_id, :integer, :null => false
    add_index :projects, :creator_id
    execute("ALTER TABLE projects ADD CONSTRAINT fk_projects_creator_id FOREIGN KEY (creator_id) REFERENCES users(id)")
  end

  def self.down
    execute("ALTER TABLE projects DROP FOREIGN KEY fk_projects_creator_id;")
    remove_index :projects, :creator_id
    remove_column :projects, :creator
  end
end
