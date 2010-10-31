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