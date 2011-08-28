class Api::RelsController < ApplicationController
  def index
    @rels = Rel.all
  end

  def show
    @rel = Rel.first(:slug => params[:id])
  end
end
