Feature: Manage expenses
  In order to see where my money are spent, 
  I 
  want to be able to enter new expenses
  
  Scenario: Register new expense
    Given I am on the homepage
    And I fill in "I spent" with "50" 
    And I fill in "For" with "Talisker 18 yrs old"
    And I fill in "category" with "Booze"
    And I press "Cough"
    Then I should see "Expense added."
    Then I should see 1 expense 
    And I should have spent 50 bucks for this month
