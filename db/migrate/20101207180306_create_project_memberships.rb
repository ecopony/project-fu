class CreateProjectMemberships < ActiveRecord::Migration
  def self.up
    create_table :project_memberships do |t|
      t.integer :project_id
      t.integer :user_id
      t.string  :role

      t.timestamps
    end

    add_index :project_memberships, :project_id
    add_index :project_memberships, :user_id
    execute("ALTER TABLE project_memberships ADD CONSTRAINT fk_project_memberships_project_id FOREIGN KEY (project_id) REFERENCES projects(id)")
    execute("ALTER TABLE project_memberships ADD CONSTRAINT fk_project_memberships_user_id FOREIGN KEY (user_id) REFERENCES users(id)")
  end

  def self.down
    execute("ALTER TABLE project_memberships DROP FOREIGN KEY fk_project_memberships_project_id;")
    execute("ALTER TABLE project_memberships DROP FOREIGN KEY fk_project_memberships_user_id;")
    remove_index :project_memberships, :project_id
    remove_index :project_memberships, :user_id
    drop_table :project_memberships
  end
end
