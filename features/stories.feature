Feature: Manage stories

  Background:
    Given there is a project named Velofight

  Scenario: Stories list visibile to project members
    Given I am logged in as a project member
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the project stories page
    Then I should see "Velofight Stories"
    And I should see "A user can log in"
    And I should see "A user can register for an account"
    And I should see "Edit"
    And I should see "Destroy"

  Scenario: Stories list not visibile to non-members
    Given I am logged in as a user
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the project stories page
    Then I should see "You are not permitted to complete this action"

  Scenario: Create and edit a story as a project member
    Given I am logged in as a project member
    And I am on the project stories page
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
    Given I am logged in as a project member
    And the following stories exist
    | title |
    | A user can log in |
    When I am on the project stories page
    And I follow "Destroy"
    Then I should see "Successfully destroyed story."

  Scenario: View stories anonymously
    Given I am logged out
    When I am on the project stories page
    Then I should see "You must be logged in to access this page"
    
  Scenario: View only member can see stories, but not edit or destroy
    Given I am logged in as a project viewer
    And the following stories exist
      | title |
      | A user can log in |
    When I am on the project stories page
    Then I should not see "Edit"
    And I should not see "Destroy"
    When I follow "A user can log in"
    Then I should be on the "A user can log in" story's show page

  Scenario: Editing stories as a viewer 
    Given I am logged in as a project viewer
    And the following stories exist
      | title |
      | A user can log in |
    When I am on the "A user can log in" story's edit page
    Then I should see "You are not permitted to complete this action"

  Scenario: Viewing the story ID
    Given I am logged in as a project member
    And there is a story titled A user can log in
    When I am on the the project stories page
    Then the story ID should be visible

    When I follow "Edit"
    Then the story ID should be visible

    # When I press "Update Story"
    # Then I should see "ID:"
    And the story ID should be visible
