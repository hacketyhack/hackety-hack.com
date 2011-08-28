HacketyHackCom::Application.routes.draw do

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
    match '/versions/newest' => 'static#newest_version', :as => "newest_version"
    scope :module => "Api" do
      resources :rels, :only => [:show]
    end
  end

  root :to => "static#root"

end
