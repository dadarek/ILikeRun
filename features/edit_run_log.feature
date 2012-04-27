Feature: Editing run logs
  In order to make changes
  As an imperfect human being
  I want to be able to edit the date and time on my run logs

  @wip
  Scenario: Deleting a run log
    Given I am logged in
    And I have entered some runs in the past
    When I visit the run log history screen
    And I click on delete next to the first run log 
    Then I should not see that first run log

    @wip
  Scenario: Editing a run log
    Given I am logged in
    And I have entered some runs in the past
    When I visit the run log history screen
    And I click on edit next to the first run log 
    When I enter 556 minutes for my time ran
    And I enter "2001-02-28" for my date ran
    Then I should have a run log with date "2001-02-28" and time ran "556"

