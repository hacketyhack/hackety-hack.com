class LessonsController < ApplicationController
  def index
    @lessons = HacketyHack::Lessons.all.collect{|lesson| [lesson.metadata["title"], lesson.metadata["slug"]]}
  end

  def show
    @lesson = HacketyHack::Lessons.find_by_slug(params[:id])
  end
end
