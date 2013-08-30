class SessionsController < ApplicationController
  def create
    raise request.env["omniauth.auth"].to yaml
  end
end
