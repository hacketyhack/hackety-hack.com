class UsersController < InheritedController
  load_and_authorize_resource
  skip_authorize_resource :only => [:following, :followers] #anyone can perform these read-only actions

end