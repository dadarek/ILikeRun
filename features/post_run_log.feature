Feature: Posting a new run log
  In order to track them in the future
  As an obsessed runner
  I want to be able to post how much I ran today

  Scenario: Posting a valid run
    Given I am logged in
    And I visit the Run log screen 
    When I enter 20 minutes for my time ran
    And I click the save button
    Then I should see a success message

  Scenario: Posting an invalid run
    Given I am logged in
    And I visit the Run log screen 
    When I enter -30 minutes for my time ran
    And I click the save button
    Then I should see an error message

  Scenario: Visiting the Run log page
    Given I am logged in
    And I visit the Run log screen 
    Then I should not see a success message
    And I should not see an error message

  Scenario: Posting a past run
    Given I am logged in
    And I visit the Run log screen 
    When I enter 560 minutes for my time ran
    And I enter "2005-05-13" for my date ran
    And I click the save button
    Then I should have a run log with date "2005-05-13" and time ran "560"
