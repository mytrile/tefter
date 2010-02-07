Feature: In order to track where do I spend all those money
  A registered user
  Should be able to enter expenses

  @wip
  Scenario: creating expenses
    Given I am signed in
    When I fill in "I spent" with "50"
    And I fill in "For" with "Dinner"
    And I fill in "Category" with "Food (outside)"
    And I press "Create Expense"
    Then I should see "Expense added"
