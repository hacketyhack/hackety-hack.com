HacketyHackCom::Application.routes.draw do

  constraints(ApiConstraint) do
    match '/' => 'static#api_root'
  end

  root :to => "static#root"

end
