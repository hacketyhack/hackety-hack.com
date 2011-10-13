class ProgramsController < InheritedController
  load_and_authorize_resource
  belongs_to :user, :optional => true

  def show
    @program = Program.find_by_slug(params[:slug])
    show!
  end

  respond_to :html, :only => [:index, :show]
end
