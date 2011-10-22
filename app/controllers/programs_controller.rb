class ProgramsController < InheritedController
  load_and_authorize_resource

  belongs_to :user, :optional => true
  respond_to :html, :only => [:index, :show]

  def show
    # @program = Program.find_by_slug(params[:slug])
    show!
  end

  #################

  def begin_of_association_chain
    if params[:user_id]
      @user = User.find_by_username params[:user_id]
      @user
    end
  end

  def resource
    @program ||= end_of_association_chain.find_by_slug(params[:id])
  end

end
