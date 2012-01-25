class LessonsController < ApplicationController
  def index
    @lessons = HacketyHack::Lessons.titles
  end

  def show
    @lesson = HacketyHack::Lessons.find_by_title(params[:id])
  end
end
