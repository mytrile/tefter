Given /^today is (.+)$/ do |moment|
  point = Chronic.parse(moment)
  Timecop.travel(point)
end

