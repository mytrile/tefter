ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'expenses'
  map.resources :expenses
  map.resources :categories, :has_many => :expenses
end
