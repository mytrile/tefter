Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I signed up with "user@example.com/example"
      When I sign in as "user@example.com/example"
      Then I should be signed in
      And I sign out
      Then I should see "Signed out"
      And I should not be signed in
      When I return next time
      Then I should not be signed in
