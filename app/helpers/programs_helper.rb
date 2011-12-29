module ProgramsHelper
  def program_link program
    "#{link_to(program.title.titleize, user_program_path(program.author_username, program))}".html_safe
  end

  def author_link username, program = nil
    output = ""
    output += link_to(username, user_path(username))

    if program
      output += ", #{program.created_at.strftime('%m/%d/%y')}" unless program.created_at.nil?
    end

    output.html_safe
  end
end
