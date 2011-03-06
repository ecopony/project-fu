class ProjectMembership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :project_id, :presence => true
  validates :user_id, :presence => true
  validates :role, :presence => true

  class << self
    def role_array
      [
          ["Member", "member"],
          ["Owner", "owner"],
          ["Viewer", "viewer"]
      ]
    end

    def valid_roles
      @valid_roles ||= role_array.map { |role| role.last }
    end
  end

  validates_inclusion_of :role, :in => self.valid_roles, :message => "is not valid"

end
