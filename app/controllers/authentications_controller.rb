class AuthenticationsController < ApplicationController
  def index
  end

  def create
    auth = request.env["omniauth.auth"] current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid']) flash[:notice] = "authentication successful."
    redirect_to => authentications_url   
# render :text => request.env["omniauth.auth"].to_yaml
  end

  def destroy
  end
  
end
