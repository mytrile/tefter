Then /^I should see 1 expense$/ do
  response.should have_tag '#expenses tbody tr', 2
end

Then /^I should have spent (\d+) bucks for (.+)$/ do |amount, time|
  date = Chronic.parse(time)
  response.should have_tag 'tr.month' do |row|
    row.should have_tag 'td', /#{date.strftime('%B')}/
    row.should have_tag 'td', /#{amount} лв/
  end
end

