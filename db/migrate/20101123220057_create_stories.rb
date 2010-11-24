class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.string :story_type
      t.integer :estimate
      t.integer :requested_by_id
      t.integer :owned_by_id
      t.text :description
      t.integer :project_id
      t.timestamps
    end

    add_index :stories, :story_type
    add_index :stories, :requested_by_id
    add_index :stories, :owned_by_id

    execute("ALTER TABLE stories ADD CONSTRAINT fk_stories_project_id FOREIGN KEY (project_id) REFERENCES projects(id)")
    execute("ALTER TABLE stories ADD CONSTRAINT fk_stories_requested_by_id FOREIGN KEY (requested_by_id) REFERENCES users(id)")
    execute("ALTER TABLE stories ADD CONSTRAINT fk_stories_owned_by_id FOREIGN KEY (owned_by_id) REFERENCES users(id)")
  end

  def self.down
    execute("ALTER TABLE stories DROP FOREIGN KEY fk_stories_project_id;")
    execute("ALTER TABLE stories DROP FOREIGN KEY fk_stories_requested_by_id;")
    execute("ALTER TABLE stories DROP FOREIGN KEY fk_stories_owned_by_id;")

    remove_index :stories, :story_type
    remove_index :stories, :requested_by_id
    remove_index :stories, :owned_by_id

    drop_table :stories
  end
end
