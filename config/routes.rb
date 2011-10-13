HacketyHackCom::Application.routes.draw do

  resources :questions do
    resources :answers
  end

  resources :programs, :only => [:index]

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
    match '/versions/newest' => 'static#newest_version', :as => "newest_version"
    scope :module => "Api" do
      resources :rels, :only => [:index, :show]
      resources :programs
    end
  end

  devise_for :users do
    get "login" => "devise/sessions#new", :as => "login"
    get "logout" => "devise/sessions#destroy", :as => "logout"
  end

  resources :users, :only => :show

  match 'users/:id/following', :controller => 'users', :action => 'following'
  match 'users/:id/followers', :controller => 'users', :action => 'followers'
  match 'users/:id/follow',    :controller => 'users', :action => 'follow'
  match 'users/:id/unfollow',  :controller => 'users', :action => 'unfollow'

  root :to => "static#root"

  match ':user_id/:slug', :to => "programs#show", :as => :program

end
