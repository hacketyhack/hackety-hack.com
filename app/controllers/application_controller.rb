class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Mongoid::Errors::DocumentNotFound
        nil
      end
    end

    def user_logged_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
      	redirect_to root_url, :alert => "Access denied."
      end
    end
 
    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to log in for access to this page.'
      end
    end
  end
  #helper_method :title

  #def title t=nil
    #@title = t unless t.blank?
    #@title
  #end
  
  #rescue_from CanCan::AccessDenied do |exception|
    #redirect_to login_url, :alert => exception.message
  #end
  
#end
