Factory.define :expense do |f|
  f.sequence :title do |n|
    "Single Malt #{n} yrs"
  end

  f.category_name "Booze"
  f.amount 50
end
