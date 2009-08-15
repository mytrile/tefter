ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'expenses'
  map.resources :expenses
end
