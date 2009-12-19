class DashboardController < ApplicationController
  def index
  end

	def inbox
		@messages = current_user.inverse_messages
	end

end
