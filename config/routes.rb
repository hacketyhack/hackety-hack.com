HacketyHackCom::Application.routes.draw do

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
    scope :module => "Api" do
      resources :rels
    end
  end

  root :to => "static#root"

end
