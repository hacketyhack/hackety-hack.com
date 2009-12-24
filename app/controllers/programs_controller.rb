class ProgramsController < ApplicationController
  prepend_around_filter ApiAuthorizedFilter.new
  
  #ugly, but here until i can inspect the issue...
  protect_from_forgery :except => :create

  def index
    @programs = Program.find(:all, :conditions => ["user_id == ?", current_user.id])
    respond_to do |format|
      format.html
      format.yaml {require 'yaml'; render :text => (Hash.from_xml(@programs.to_xml)).to_yaml}
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def new
    @program = Program.new
  end

  def edit
    @program = Program.find(params[:id])
    if current_user != @program.user
      redirect_to root_url
      return
    end
  end

  def create
    @program = Program.new(params[:program])
		@program.user = current_user

		if @program.save
			flash[:notice] = 'Program was successfully created.'
			redirect_to(@program)
		else
			render :action => "new"
		end
  end

  def update
    @program = Program.find(params[:id])
    if current_user != @program.user
      redirect_to root_url
      return
    end

		if @program.update_attributes(params[:program])
			flash[:notice] = 'Program was successfully updated.'
			redirect_to(@program)
		else
			render :action => "edit"
		end
  end

  def destroy
    @program = Program.find(params[:id])
    if current_user != @program.user
      redirect_to root_url
      return
    end
    @program.destroy
		redirect_to user_path(current_user.username)
  end
end
