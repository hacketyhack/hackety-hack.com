class Api::RelsController < ApplicationController
  def show
    @rel = Rel.first(:slug => params[:id])
  end
end
