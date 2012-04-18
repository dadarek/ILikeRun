@wip
Feature: Posting a new run log
  In order to track them in the future
  As an obsessed runner
  I want to be able to post how much I ran today

  Scenario: Posting a valid run
    Given I am logged in
    And I am on the Run log page
    When I enter 20 minutes for my time ran
    And I click the save button
    Then I should see a success message

  Scenario: Posting an invalid run
    Given I am logged in
    And I am on the Run log page
    When I enter -30 minutes for my time ran
    And I click the save button
    Then I should see an error message

  Scenario: Visiting the Run log page
    Given I am logged in
    And I am on the Run log page
    Then I should not see a success message
    And I should not see an error message
