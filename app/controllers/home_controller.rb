class HomeController < ApplicationController
  def index
  	@user = User.all
  end

end
