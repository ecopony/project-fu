Feature: Project members

  Background:
    Given there is a project named Velofight
    And the following users exist
    | email |
    | bob@example.com |
    
  Scenario: Project owner can add a project member as a member
    Given I am logged in as a project owner
    When I am on the project settings page
    And I follow "Members"
    And I select "bob@example.com" from "User"
    And I select "Member" from "Role"
    And I press "Create Project membership"
    Then I should see "Successfully created project membership."

  Scenario: Project member (non-owner) can't add a project member
    Given I am logged in as a project member
    When I am on the project settings page
    And I follow "Members"
    Then I should not see form fields for adding members

  Scenario: Non-member can't add a project member
    Given I am logged in as a user
    When I am on the project settings page
    And I follow "Members"
    Then I should not see form fields for adding members
