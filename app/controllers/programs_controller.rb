class ProgramsController < InheritedController
  load_and_authorize_resource

  belongs_to :user, :optional => true

  respond_to :html, :only => [:index, :show]
end
