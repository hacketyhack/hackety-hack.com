class DashboardController < ApplicationController
	
  def index
		@messages = current_user.inverse_messages
  end

end
