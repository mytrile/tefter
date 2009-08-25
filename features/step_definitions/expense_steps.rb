Then /^I should see 1 expense$/ do
  response.should have_tag '#expenses tbody tr', 2
end

Then /^I should have spent (\d+) bucks for (.+)$/ do |amount, time|
  date = Chronic.parse(time)
  month = date.strftime '%B'
  response.should have_tag "table[summary~=#{month}]" do |table|
    table.should have_tag 'thead' do |head|
      head.should have_tag('th', /#{month}/)
      head.should have_tag('th.price', /#{'%0.2f'% amount}/)
    end
  end
end

