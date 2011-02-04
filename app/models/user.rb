class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :project_memberships
  has_many :projects, :through => :project_memberships, :source => :project, :uniq => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

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
end
