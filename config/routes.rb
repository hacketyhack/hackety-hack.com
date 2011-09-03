HacketyHackCom::Application.routes.draw do

  resources :questions

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

  root :to => "static#root"

end
