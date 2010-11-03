Feature: Manage projects

  In order to maintain projects
  As a user
  I want to create and manage projects

  Background:
    Given I am logged in as a user

  Scenario: Projects list
    Given the following projects exist
    | name |
    | Velofight |
    | Project Huxley |
    When I go to the projects page
    Then I should see "Velofight"
    Then I should see "Project Huxley"

  Scenario: Create and edit a project
    Given I am on the projects page
    When I follow "New Project"
	  And I fill in "Name" with "Velofight"
	  And I press "Create Project"
	  Then I should see "Successfully created project."
	  And I should see "Velofight"
	
	  When I follow "Edit"
	  And I fill in "Name" with "Velofight!"
	  And I press "Update Project"
	  Then I should see "Successfully updated project."
    And I should see "Velofight!"

  Scenario: Deleting a project
    Given the following projects exist
    | name |
    | Velofight |
    When I go to the projects page
    And I follow "Destroy"
    Then I should see "Successfully destroyed project."
    
    
    
  