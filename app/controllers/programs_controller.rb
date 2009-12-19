class ProgramsController < ApplicationController
  def index
    @programs = Program.all
  end

  def show
    @program = Program.find(params[:id])
  end

  def new
    @program = Program.new
  end

  def edit
    @program = Program.find(params[:id])
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

		if @program.update_attributes(params[:program])
			flash[:notice] = 'Program was successfully updated.'
			redirect_to(@program)
		else
			render :action => "edit"
		end
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
  end
end
