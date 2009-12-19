ActionController::Routing::Routes.draw do |map|

  map.resources :users, :except => :show
	map.user "/users/:username", :controller => "users", :action => "show"

	map.root :controller => "welcome"

	map.dashboard "/dashboard", :controller => "dashboard"

	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

	map.resources :user_sessions
	map.resources :watchings

end
