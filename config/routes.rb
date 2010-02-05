ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.sign_up "sign_up", :controller => "users", :action => "new"
  map.sign_in "sign_in", :controller => "user_sessions", :action => "new"
  map.sign_out "sign_out", :controller => "user_sessions", :action => "destroy"
  map.resource :users
  map.resource :user_session
  map.resources :expenses

  # rspec needs this
  map.resources :dummies
end
