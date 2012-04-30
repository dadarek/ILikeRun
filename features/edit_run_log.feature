Feature: Editing run logs
  In order to make changes
  As an imperfect human being
  I want to be able to edit the date and time on my run logs

  Scenario: Deleting a run log
    Given I am logged in
    And I have the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
    When I visit the run log history screen
    And I click on delete next to the first run log 
    Then I should not have the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |

  Scenario: Editing a run log
    Given I am logged in
    And I have the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
    When I visit the run log history screen
    And I click on edit next to the first run log 
    When I enter 556 minutes for my time ran
    And I enter "2001-02-28" for my date ran
    And I click the "Save" button
    Then I should have the following run logs
      | date_ran | time_ran |
      | 2001-02-28 | 556 |
    And I should not have the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
