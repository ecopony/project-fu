Feature: User dashboard

  Background:
    Given I am logged in as a user

  Scenario: View dashboard
    When I am on the dashboard page
    Then I should see "project-fu"
    And I should see "Projects"
    
    
    
  