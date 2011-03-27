Feature: Story workflow

  Background:
    Given there is a project named Velofight
    And the following stories exist
    | title |
    | A user can log in |

  @javascript
  Scenario: Taking a story through the workflow
    Given I am logged in as a project member
    When I am on the project stories page
    And I follow "Start"
    Then I should see "Finish"

    When I follow "Finish"
    Then I should see "Accept"
    And I should see "Reject"

    When I follow "Reject"
    Then I should see "Restart"

    When I follow "Restart"
    And I follow "Finish"
    And I follow "Accept"
    Then I should see "Completed"

  Scenario: Workflow permissions for a project viewer
    Given I am logged in as a project viewer
    When I am on the project stories page
    Then I should not see "Start"
