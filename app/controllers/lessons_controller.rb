class LessonsController < ApplicationController
  def index
    @lessons = HacketyHack::Lessons.all
  end

  def show
    @lesson = HacketyHack::Lessons.find_by_slug(params[:id])
  end
end
