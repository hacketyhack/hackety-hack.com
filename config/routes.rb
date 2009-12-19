ActionController::Routing::Routes.draw do |map|
  map.resources :programs

  map.resources :messages


  map.resources :users, :except => :show
	map.user "/users/:username", :controller => "users", :action => "show"

	map.root :controller => "welcome"

	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

	map.resources :user_sessions
	map.resources :watchings
	map.resources :comments

end
