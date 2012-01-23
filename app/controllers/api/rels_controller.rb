class Api::RelsController < ApiController
  def index
    @rels = Rel.all
  end

  def show
    @rel = Rel.first(:slug => params[:id])
  end
end
