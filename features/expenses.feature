Feature: Manage expenses
  In order to see where my money are spent, 
  I want to be able to enter new expense, and review my current ones
  
  Scenario: Register new expense
    Given I am on the homepage
    And I fill in "I spent" with "50" 
    And I fill in "For" with "Talisker 18 yrs old"
    And I fill in "category" with "Booze"
    And I press "Cough"
    Then I should see "Expense added."
    Then I should see 1 expense 
    And I should have spent 50 bucks for this month

  Scenario: Reviewing older expenses
    Given I have 50 expenses
    And I am on the homepage
    Then I should see 30 expenses
    When I paginate to page 2
    Then I should see 20 expenses
  
  Scenario: Filtering by categories
    Given I have spent 50 for Lagavulin - Booze
    And I have spent 40 for Talisker - Booze
    And I have spent 30 for Cohiba - Blaze
    When I am on the homepage
    And I follow "Booze"
    Then the "category" field should contain "Booze"
    Then I should see "Expenses marked as Booze"
    And I should see 2 expenses

  Scenario: Editing expense
    Given I have spent 50 for Lagavulin - Booze
    And I am on the homepage
    When I follow "Lagavulin" 
    And I fill in "category" with "Recr."
    And I fill in "For" with "Talisker"
    And I fill in "I spent" with "30"
    And I press "Change"
    Then I should see "Expense updated" 
    And I should have spent 30 bucks for this month
