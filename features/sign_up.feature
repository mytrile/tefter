Feature: Signing up
  In order to use the service feature
  An user
  Should be able to sign up

  @wip
  Scenario: successful sign up
    Given I am on the homepage
    When I follow "Sign Up"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "example"
    And I fill in "Password (again)" with "example"
    And I press "Sign Up"
    Then I should be signed in
    And I should be on the homepage
    And I should see "Thanks for Signing up"
