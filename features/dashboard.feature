Feature: User dashboard

  Scenario: View dashboard anonymously
    Given the following projects exist
    | name |
    | Velofight |
    | Project Huxley |
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should see "Sign up or Sign in"
    And I should not see "Project Huxley"

  Scenario: View dashboard as a logged in user
    Given I am logged in as a user
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should see "New Project"

  Scenario: View existing projects on the dashboard as a logged in user
    Given I am logged in as a user
    And the following projects exist
    | name |
    | Velofight |
    | Project Huxley |
    And I am a member of project "Velofight"
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should see "Velofight"
    And I should not see "Project Huxley"
  