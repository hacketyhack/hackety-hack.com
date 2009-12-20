# Use this filter as an around_filter around actions that can be
# accessed via the API.
#
# Example:
#   class ItemsController < ApplicationController
#     prepend_around_filter ApiAuthorizedFilter.new, :only => [:create]
#   end
#
class ApiAuthorizedFilter
  def before(controller)
    return true unless controller.params[:api_key]
    controller.current_user = User.find_by_api_key(controller.params[:api_key])
  end

  def after(controller)
    controller.current_user = nil
  end
end

