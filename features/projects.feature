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
    When I am on the projects page
    Then I should see "Velofight"
    Then I should see "Project Huxley"

  Scenario: Create a project
    Given I am on the projects page
    When I follow "New Project"
	  And I fill in "Name" with "Velofight"
	  And I press "Create Project"
	  Then I should see "Successfully created project."
	  And I should see "Velofight"
      And the project should have a creator

  Scenario: View project stories on the project page
    Given there is a project named Velofight
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
    Then I should see "You need to sign in or sign up before continuing."

