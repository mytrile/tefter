Factory.define :user do |f|

end

Factory.define :registered_user, :parent => :user do |f|

  f.sequence :email do |n|
    "user#{n}@example.com"
  end

  f.password "example"
  f.password_confirmation "example"
end
