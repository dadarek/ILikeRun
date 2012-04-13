Feature: Posting a new run log
  In order to track them in the future
  As a obsessed runner
  I want to be able to post how much I ran today

  Scenario: Posting a valid run
    Given I am on the Run log page
    When I fill in 20 into the time ran box
    And I click the save button
    Then I see a success message

  Scenario: Posting an invalid run
    Given I am on the Run log page
    When I fill in -20 into the time ran box
    And I click the save button
    Then I see an error message

  Scenario: Visiting the Run log page
    Given I am on the Run log page
    Then I do not see a success message
    And I do not see an error message
