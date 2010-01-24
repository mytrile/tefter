ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.sign_up "sign_up", :controller => "users", :action => "new"
  map.sign_in "sign_in", :controller => "user_sessions", :action => "new"
  map.resource :users

  # rspec needs this
  map.resources :dummies
end
