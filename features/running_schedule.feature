Feature: Running Schedule
  In order to remind myself of when I should run
  As an obsessed runner
  I would like to manage a running schedule

  Scenario: Viewing Current Schedule
    Given I am logged in
    And My schedule has the following days
      | day       |
      | Tuesday   |
      | Wednesday |
      | Saturday  |

    When I click on "Schedule"
    Then My schedule should look like this
      | day       | running? |
      | Sunday    |          |
      | Monday    |          |
      | Tuesday   |    X     |
      | Wednesday |    X     |
      | Thursday  |          |
      | Friday    |          |
      | Saturday  |    X     |

  Scenario: Removing Days from Schedule
    Given I am logged in
    And My schedule has the following days
      | day       |
      | Tuesday   |
      | Wednesday |
      | Saturday  |

    And I am on the schedule page

    When I click on the image for "Tuesday"
    Then My schedule should look like this
      | day       | running? |
      | Sunday    |          |
      | Monday    |          |
      | Tuesday   |          |
      | Wednesday |    X     |
      | Thursday  |          |
      | Friday    |          |
      | Saturday  |    X     |

  @wip
  Scenario: Adding Days to Schedule
    Given I am logged in
    And My schedule has Tuesday and Saturday
    When I click on "Update Schedule"
    And I select Monday
    And I click on "Save"
    Then My schedule should have Monday, Tuesday, and Saturday

  @wip
  Scenario: Other users updating their schedule
    Given There are 2 users in the system
    And One user updates his schedule
    Then The other users schedule should not be affected

