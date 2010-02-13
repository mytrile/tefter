Feature: In order to track where do I spend all those money
  A registered user
  Should be able to enter expenses

  Scenario: creating expenses
    Given I am signed in
    When I fill in "I spent" with "50"
    And I fill in "For" with "Dinner"
    And I fill in "Category" with "Food (outside)"
    And I press "Create Expense"
    Then I should see "Expense added"

  @wip
  Scenario: reviewing expenses
    Given today is 5 December 2009
    And I am signed in
    And yesterday I spent 50 for Dinner, Food (outside)
    And 2 days ago I spent 150 for Dinner, Food (outside)
    And I am on the homepage
    When I follow "Expenses (2)"
    Then I should see "yesterday $50.00 Dinner (Food (outside))"
    And I should see "3 Dec $150.00 Dinner (Food (outside))"
