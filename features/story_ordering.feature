Feature: Reordering stories

  @javascript
  Scenario: Ordering stories
    Given there is a project named Velofight
    And the following stories exist
    | title |
    | A user can drag |
    | A user can drop |
    | A user can sag |
    And I am logged in as a project member
    When I am on the project stories page
    And I drag "A user can drag" down 300 pixels
    # The rest will follow once that ^ is working
