Feature: User accounts

  In order to maintain user accounts
  As an user
  I want to create and manage a user account

  Scenario: User registration
    When I go to the home page
    And I follow "Sign up"
    And I fill in "Login" with "testuser"
    And I fill in "Email" with "testuser@velofight.com"
    And I fill in "Password" with "velofight!"
    And I fill in "Password confirmation" with "velofight!"
    And I press "Submit"
    Then I should see "Registration successful"

   Scenario: Failed user registration
    When I go to the home page
    And I follow "Sign up"
    And I fill in "Login" with "testuser"
    And I fill in "Email" with "testuser@velofight.com"
    And I fill in "Password" with "velofight!"
    And I press "Submit"
    Then I should see "Correct the following errors and try again."

  Scenario: User log in
    Given I have a user "testuser" identified by "velofight!"
    When I go to the home page
    And I follow "Sign in"
    And I fill in "Login" with "testuser"
    And I fill in "Password" with "velofight!"
    And I press "Sign in"
    Then I should see "Successfully logged in"
    
  Scenario: Failed user log in
    Given I have a user "testuser" identified by "velofight!"
    When I go to the home page
    And I follow "Sign in"
    And I fill in "Login" with "testuser"
    And I fill in "Password" with "notmypassword!"
    And I press "Sign in"
    Then I should see "Correct the following errors and try again."
