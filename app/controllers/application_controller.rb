class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :title

  def title t=nil
    @title = t unless t.blank?
    @title
  end
end
