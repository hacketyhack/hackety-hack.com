module ProgramsHelper
  # def program_link program_name, program_slug, username
  #   "#{link_to(program_name, user_program_path(username, program_slug))} by #{link_to(username, user_path(username))}".html_safe
  # end
  def program_link program
    "#{link_to(program.title, user_program_path(program.author_username, program))}".html_safe
  end

  def author_link username
    "#{link_to(username, user_path(username))}".html_safe
  end
end
