Factory.factories.each do |name, factory|
  Given /^an? #{name.to_s.humanize.downcase} exists with an? (.*) of "([^"]*)"$/ do |attr, value|
    Factory(name, attr.gsub(' ', '_') => value)
  end
end
