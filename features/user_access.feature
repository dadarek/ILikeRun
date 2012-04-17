@wip
Feature: User Access
  In order to be able to track many users
  Every user should be able to manage their own logs

  Scenario: Logging In 
    Given a user "Fred" with password "pickle"
    When I visit the login screen
    And I fill in "Fred" for "username"
    And I fill in "pickle" for "password"
    Then I should be logged in
    And I should be on the "log new run" screen

  Scenario: Logging in with invalid credentials
    Given a user "Smith" with password "apple"
    When I visit the login screen
    And I fill in "Smith" for "username"
    And I fill in "gravity" for "password"
    Then I should not be logged in 

  Scenario: Posting runs as user
    Given I am logged in
    And I go to create a new run log
    When I fill in "600" minutes for "time ran"
    And I click the save button
    Then My history should have a log with 600 minutes

  Scenario: Automatic Logout
    Given I am logged in
    When I do not use the site for 30 minutes
    Then I should be automatically logged out
    And I should be on the login screen

  Scenario: Logging out
    Given I am logged in
    When I click on log out
    Then I should not be logged in
    And I should be on the login screen

    # TODO 
    # Question for Eric:
    # Should I write a scenario for
    # encrypted passwords?

