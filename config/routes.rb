HacketyHackCom::Application.routes.draw do

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
    match '/versions/newest' => 'static#newest_version', :as => "newest_version"
    scope :module => "Api" do
      resources :rels, :only => [:index, :show]
    end
  end

  devise_for :users

  root :to => "static#root"

end
