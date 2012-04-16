Feature: List past runs
  In order see if I am getting better
  As an obsessive runner
  I want to be able to view my run history

  Scenario: Viewing runs
    Given I have entered some runs in the past
    When I visit the run log history screen
    Then I should see those runs ordered by most-recent first

