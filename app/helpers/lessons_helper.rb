module LessonsHelper

  def lesson_categories lesson
    output = content_tag :ul, :class => "lesson-categories" do
      lesson.metadata["categories"].reduce('') { |c, x|
        c << content_tag(:li, x, :class => x)
      }.html_safe
    end
  end

end
