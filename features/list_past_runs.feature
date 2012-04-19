Feature: List past runs
  In order see if I am getting better
  As an obsessive runner
  I want to be able to view my run history

  @wip
  Scenario: Viewing only my runs
    Given I am logged in
    And I have entered some runs in the past
    And Other users have also entered runs in the past
    When I visit the run log history screen
    Then I should see my runs
    And I should not see other peoples runs

  Scenario: Viewing runs in order
    Given I am logged in
    And I have entered some runs in the past
    When I visit the run log history screen
    Then I should see my runs ordered by most-recent first

  Scenario: Navigating to runs
    Given I am logged in
    And I am on the enter-run-log page
    When I click on history
    Then I go to the history page

