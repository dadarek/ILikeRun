Feature: User Access
  In order to be able to track many users
  Every user should be able to manage their own logs

  Scenario: Logging In 
    Given a user "Fred" with password "pickle"
    When I visit the login screen
    And I fill in "Fred" for "username"
    And I fill in "pickle" for "password"
    And I click the "Login" button
    Then I should be logged in
    And I should be on the "log new run" screen

  Scenario: Logging in with invalid credentials
    Given a user "Smith" with password "apple"
    When I visit the login screen
    And I fill in "Smith" for "username"
    And I fill in "gravity" for "password"
    Then I should not be logged in 

  @wip
  Scenario: Automatic Logout
    Given I am logged in
    When I do not use the site for 30 minutes
    Then I should be automatically logged out
    And I should be on the "home page" screen

  Scenario: Logging out
    Given I am logged in
    When I click on "Logout"
    Then I should not be logged in
    And I should be on the "home page" screen

