Feature: User navigation

  Background:
    Given I am logged in as a user

  Scenario: Navigate back to the dashboard
    Given there is a project named Velofight
    When I am on the projects page
    Then I should see "project-fu"

    When I follow "project-fu"
    Then I should be on the dashboard page

  Scenario: Navigate back to projects from stories
    And there is a project named Velofight
    And the following stories exist
    | title |
    | A user can log in |
    | A user can register for an account |
    When I am on the the project stories page
    Then I should see "project-fu"

    When I follow "project-fu"
    Then I should be on the dashboard page
  