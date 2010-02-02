Then /^I should be signed in$/ do
  signed_in?.should be_true
end

Then /^I should not be signed in$/ do
  signed_in?.should be_false
end

Given /^I signed up with "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign In"}
end

When /^session is cleared$/ do
  request.reset_session
  controller.instance_variable_set(:@_current_user, nil)
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end

When /^I sign out$/ do
  visit '/sign_out'
end
