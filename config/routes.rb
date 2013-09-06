HacketyHackCom::Application.routes.draw do

  get "users/index"

  match 'mailer' => 'mailer#new', :as => 'mailer', :via => :get
  match 'mailer' => 'mailer#create', :as => 'mailer', :via => :post
  get 'users/deleted_user', :to => 'users#deleted_user'

  resources :lessons, :only => [:index, :show]

  resources :questions do
    resources :answers
  end

  resources :blog, :controller => "blog" do
    match "admin", :on => :collection, :controller => "blog", :action => "admin"
  end

  get "/downloads/latest/:platform", :to => "static#download", :as => 'downloads'
  get "/downloads/latest", :to => "static#download", :as => 'download'
  match "/download" => redirect("/downloads/latest")

  scope '/support', :as => 'support' do
    resources :questions, :controller => 'questions' do
      resources :answers
    end
  end

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
    match '/versions/newest' => 'static#newest_version', :as => "newest_version"
    scope :module => "Api" do
      resources :rels, :only => [:index, :show]
        resources :programs
    end
  end

  resources :programs, :only => [:index, :show]

  devise_for :users
  devise_scope :user do
    get "login" => "devise/sessions#new", :as => "login"
    get "logout" => "devise/sessions#destroy", :as => "logout"
  end

  resources :users, :constraints => { :id => /.*/ }, :only => :show do
    get "following" => "users#following", :as => :following
    get "followers" => "users#followers", :as => :followers
    post "follow" => "users#follow", :as => :follow
    post "unfollow" => "users#unfollow", :as => :unfollow

    resources :programs
  end

  # match ':user_id/:slug', :to => "programs#show", :as => :program

  match 'faq' => 'static#faq'
  match 'contribute' => 'static#contribute'
  root :to => "static#root"

end
