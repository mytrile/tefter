Then /^I should see (\d+) expenses?$/ do |count|
  response.should have_tag '#expenses tbody tr', count.to_i + 1
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

Given /^I have (\d+) expenses?$/ do |count|
  count.to_i.times do
    Factory(:expense)
  end
end

Given /^I have spent (\d+) for (.+) \- (.+)$/ do |amount, title, category_name|
  Factory :expense, :amount => amount, :title => title, :category_name => category_name
end
