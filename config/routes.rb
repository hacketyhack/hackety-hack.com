HacketyHackCom::Application.routes.draw do

  resources :questions do
    resources :answers
  end
  
  scope '/support', :as => 'support' do
    resources :questions, :controller => 'questions'
  end
  
  resources :programs, :only => [:index, :show]

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

  resources :users, :only => :show do
    get "following" => "users#following", :as => :following
    get "followers" => "users#followers", :as => :followers
    post "follow" => "users#follow", :as => :follow
    post "unfollow" => "users#unfollow", :as => :unfollow

    resources :programs
  end

  # match ':user_id/:slug', :to => "programs#show", :as => :program

  match 'faq' => 'static#faq'
  root :to => "static#root"

end
