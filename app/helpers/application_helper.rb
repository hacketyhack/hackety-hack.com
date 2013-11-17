module ApplicationHelper
  def program_path program
    "/users/#{program.author_username}/programs/#{program.slug}"
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true), autolink: true).render(text).html_safe
  end
end
