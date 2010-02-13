Given /^(.+) I spent (\d+) for (.+), (.+)$/ do |created_at, amount, title, category_name|
  current_user.expenses.create :amount => amount,
    :title => title,
    :category_name => category_name,
    :created_at => Chronic.parse(created_at),
    :created_on => Chronic.parse(created_at).to_date
end

