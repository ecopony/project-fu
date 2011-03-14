Feature: Manage projects

  In order to maintain projects
  As a user
  I want to create and manage projects

  Scenario: Projects list should show projects of which the user is a member
    Given I am logged in as a user
    And the following projects exist
    | name |
    | Velofight |
    | Project Huxley |
    And I am a member of project "Velofight"
    When I am on the projects page
    Then I should see "Velofight"
    Then I should not see "Project Huxley"

  Scenario: Create a project
    Given I am logged in as a user
    And I am on the projects page
    When I follow "New Project"
	And I fill in "Name" with "Velofight"
    And I fill in "Unit scale" with "0, 1, 2, 3, 5, 8, 13, 20, 40, 100"
	And I press "Create Project"
	Then I should see "Successfully created project."
	And I should see "Velofight"
    And the project should have a creator

  Scenario: Edit a project settings as a project member
    Given there is a project named Velofight
    And I am logged in as a project owner
    And I am on the project page
    When I follow "Settings"
	  And I fill in "Name" with "Velofight!"
	  And I press "Update Project"
	  Then I should see "Successfully updated project."
	  And I should see "Velofight!"

  Scenario: Make the project private
    Given there is a project named Sparrowhawk
    And I am logged in as a project owner
    And I am on the project page
    When I follow "Settings"
    And I check "Private"
    And I press "Update Project"
    Then I should see "Successfully updated project."
    
  Scenario: Non-owners should not be able to edit project settings
    Given there is a project named Velofight
    And I am logged in as a project member
    And I am on the project page
    And I follow "Settings"
    Then I should see "You are not permitted to complete this action"

  Scenario: View project stories on the project page
    Given there is a project named Velofight
    And I am logged in as a project member
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the project page
    Then I should see "A user can log in"
    And I should see "A user can register for an account"

  Scenario: View projects anonymously
    Given I am logged out
    When I am on the projects page
    Then I should see "You must be logged in to access this page"

