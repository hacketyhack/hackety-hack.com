module ProgramsHelper
  def program_link program_name, program_slug, username
    "#{link_to(program_name, user_program_path(username, program_slug))} by #{link_to(username, user_path(username))}".html_safe
  end
end
