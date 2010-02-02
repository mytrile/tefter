Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Scenario: User signs in successfully
    Given I signed up with "user@example.com/example"
    When I go to the sign in page
    And I sign in as "user@example.com/example"
    Then I should be signed in
    When I return next time
    Then I should be signed in

  Scenario: User enters wrong password
    Given I signed up with "user@example.com/example"
    When I go to the sign in page
    And I sign in as "user@example.com/wrong"
    Then I should see "Email/Password combination is not valid."
    And I should not be signed in
