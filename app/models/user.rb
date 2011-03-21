class User < ActiveRecord::Base
  acts_as_authentic

  has_many :project_memberships
  has_many :projects, :through => :project_memberships, :source => :project, :uniq => true

  class << self

    def eligible_for_membership_to(project)
      raise if (project.nil? || !project.is_a?(Project))
      project_member_ids = project.project_member_ids
      User.order("email ASC").reject { |user| project_member_ids.include?(user.id) }
    end

  end

  def is_a_owner_of?(project)
    project.owners.include?(self)
  end
  alias owns? is_a_owner_of?

  def is_a_member_of?(project)
    project.project_members.include?(self)
  end

  def is_an_editor_of?(project)
    project.editors.include?(self)
  end
end
