class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :title

  def title t=nil
    @title = t unless t.blank?
    @title
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, :alert => exception.message
  end
  
end
