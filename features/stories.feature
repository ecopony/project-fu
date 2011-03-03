Feature: Manage stories

  Background:
    Given there is a project named Velofight

  Scenario: Stories list visibile to project members
    Given I am logged in as a project member
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the the project stories page
    Then I should see "Velofight Stories"
    And I should see "A user can log in"
    And I should see "A user can register for an account"

  Scenario: Stories list not visibile to non-members
    Given I am logged in as a user
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the the project stories page
    Then I should see "You are not permitted to complete this action"

  Scenario: Create and edit a story as a project member
    Given I am logged in as a project member
    And I am on the the project stories page
    When I follow "New Story"
	And I fill in "Title" with "A user can log in"
	And I select "Story" from "Story type"
	And I fill in "Requested by" with "1"
	And I press "Create Story"
	Then I should see "Successfully created story."
	And I should see "A user can log in"

    When I follow "Edit"
	And I fill in "Title" with "A user can login"
	And I press "Update Story"
	Then I should see "Successfully updated story."
    And I should see "A user can login"

  Scenario: Deleting a story
    Given I am logged in as a project member
    And the following stories exist
    | title |
    | A user can log in |
    When I am on the the project stories page
    And I follow "Destroy"
    Then I should see "Successfully destroyed story."

  Scenario: View stories anonymously
    Given I am logged out
    When I am on the the project stories page
    Then I should see "You must be logged in to access this page"
    
  