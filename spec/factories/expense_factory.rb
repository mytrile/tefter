Factory.define :expense do |f|
  f.association :user, :factory => :registered_user
  f.title  "Pizza"
  f.amount  50
  f.category_name  "Food"
end
