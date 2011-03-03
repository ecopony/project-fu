Feature: Manage stories

  Background:
    Given there is a project named Velofight
    And there is a project member with the login "velofighter"
    And I am logged in as a project member
    And I am on the the project stories page
    When I follow "New Story"
	And I fill in "Title" with "A user can log in"
	And I press "Create Story"

  Scenario: Story requested-by should default to current user
	Then the requested by user should be the current user

  Scenario: After an edit, requested by should be the value entered
    When I follow "Edit"
    And I select "velofighter" from "Requested by"
    And I press "Update Story"
    Then I should see "Requested By: velofighter"

  Scenario: Story type should default to Story
	Then I should see "Story Type: story"

  Scenario: After an edit, the story type should be the value entered
    When I follow "Edit"
    And I select "Epic" from "Story type"
    And I press "Update Story"
    Then I should see "Story Type: epic"


