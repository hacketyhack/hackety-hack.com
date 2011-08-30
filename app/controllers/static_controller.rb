class StaticController < ApplicationController
  def root; end
  def api_root; render :layout => "api"; end
  def newest_version
    render :json => {:version => "1.0.0"}
  end
end
