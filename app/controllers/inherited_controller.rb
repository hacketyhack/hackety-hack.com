class InheritedController < ApplicationController
  inherit_resources

  before_filter :form_url, :only => [:new, :create, :edit, :update]

  # Set form url instance variable correctly depending on action
  def form_url

    # this line is to fix a bug that I was getting.
    # if you remove it, maybe try commenting it out instead.
    # if you get this bug:
    # undefined method `model_name' for NilClass:Class
    # ...
    # app/controllers/inherited_controller.rb:39:in `form_url'
    #
    # etc, then try adding it back in.
    begin
      resource.inspect
    rescue
    end
    # end of bug fix.


    if ['new','create'].include? params[:action]
      @form_url = collection_path
    elsif
      @form_url = resource_path
    end
  end

end
