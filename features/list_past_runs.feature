Feature: List past runs
  In order see if I am getting better
  As an obsessive runner
  I want to be able to view my run history

  Scenario: Viewing runs
    Given I am on the run log history screen
    And I have entered some runs in the past
    Then I should see the runs I entered

