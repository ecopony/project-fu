Feature: Project members

  Background:
    Given there is a project named Velofight
    And the following users exist
    | email |
    | bob@example.com |
    
  Scenario: Project owner can add a project member as a member
    Given I am logged in as a project owner
    When I am on the project page
    And I follow "Members"
    And I select "bob@example.com" from "User"
    And I select "Member" from "Role"
    And I press "Create Project membership"
    Then I should see "Successfully created project membership."
    And I should see "bob@example.com" within "div#project_members"
    And I should see "Member" within "div#project_members"

  Scenario: Project owner can add a project member as a viewer
    Given I am logged in as a project owner
    When I am on the project page
    And I follow "Members"
    And I select "bob@example.com" from "User"
    And I select "Viewer" from "Role"
    And I press "Create Project membership"
    Then I should see "Successfully created project membership."
    And I should see "bob@example.com" within "div#project_members"
    And I should see "viewer" within "div#project_members"

  Scenario: Project member (non-owner) can't add a project member
    Given I am logged in as a project member
    When I am on the project members page
    Then I should not see form fields for adding members

  Scenario: Project member (non-owner) can see the project members
    Given I am logged in as a project member
    When I am on the project members page
    Then I should see "Project Members" within "div#project_members"
  
  Scenario: Non-member can't add a project member
    Given I am logged in as a user
    When I am on the project members page
    Then I should not see form fields for adding members

  Scenario: Non-member can't see the project members
    Given I am logged in as a user
    When I am on the project members page
    Then I should not see "Project Members"

