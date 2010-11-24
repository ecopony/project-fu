Feature: Manage stories

  Background:
    Given I am logged in as a user
    And there is a project named Velofight

  Scenario: Stories list
    Given the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the the project stories page
    Then I should see "Velofight Stories"
    And I should see "A user can log in"
    And I should see "A user can register for an account"

  Scenario: Create and edit a story
    Given I am on the the project stories page
    When I follow "New Story"
	And I fill in "Title" with "A user can log in"
	And I press "Create Story"
	Then I should see "Successfully created story."
	And I should see "A user can log in"

    When I follow "Edit"
	And I fill in "Title" with "A user can login"
	And I press "Update Story"
	Then I should see "Successfully updated story."
    And I should see "A user can login"

  Scenario: Deleting a story
    Given the following stories exist
    | title |
    | A user can log in |
    When I am on the the project stories page
    And I follow "Destroy"
    Then I should see "Successfully destroyed story."

  Scenario: View stories anonymously
    Given I am logged out
    When I am on the the project stories page
    Then I should see "You need to sign in or sign up before continuing."
    
    
  