Then /^I should see 1 expense$/ do
  response.should have_tag '#expenses tbody tr', 2
end

Then /^I should have spent 50 bucks for this month$/ do
  pending
end

