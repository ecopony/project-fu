Feature: User dashboard

  Scenario: View dashboard anonymously
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should not see "Projects"

  Scenario: View dashboard as a logged in user
    Given I am logged in as a user
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should see "Projects"
  