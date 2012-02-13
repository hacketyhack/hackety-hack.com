module ProgramsHelper
  def program_link program
    if program.author_username.present?
      "#{link_to(program.title.titleize, user_program_path(program.author_username, program))}".html_safe
    else
      "#{link_to(program.title.titleize, url_for(:controller => '/programs', :action => 'show', :id => program.slug))}".html_safe
    end
  end

  def author_link username, program = nil
    return nil unless username
    output = ""
    output += link_to(username, user_path(username))

    if program
      output += ", #{program.created_at.strftime('%m/%d/%y')}" unless program.created_at.nil?
    end

    output.html_safe
  end
end
