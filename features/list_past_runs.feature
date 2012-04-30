Feature: List past runs
  In order see if I am getting better
  As an obsessive runner
  I want to be able to view my run history

  Scenario: Viewing only my runs
    Given I am logged in
    And I have the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
      | 2002-03-30 | 10 |
    And Another user has the following run logs
      | date_ran | time_ran |
      | 2000-03-21 | 88 |
      | 2001-11-22 | 99 |
    When I visit the run log history screen
    Then I should see the following run logs
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
      | 2002-03-30 | 10 |
    Then I should not see the following run logs
      | date_ran | time_ran |
      | 2000-03-21 | 88 |
      | 2001-11-22 | 99 |

  Scenario: Viewing runs in order
    Given I am logged in
    And I have the following run logs
      | date_ran | time_ran |
      | 2008-10-12 | 15 |
      | 2012-02-12 | 20 |
      | 2002-03-30 | 10 |
    When I visit the run log history screen
    Then I should see the following run logs in this order
      | date_ran | time_ran |
      | 2012-02-12 | 20 |
      | 2008-10-12 | 15 |
      | 2002-03-30 | 10 |

  Scenario: Navigating to runs
    Given I am logged in
    And I visit the enter-run-log screen 
    When I click on history
    Then I should be on the history page

