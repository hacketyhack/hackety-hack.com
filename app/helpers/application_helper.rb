module ApplicationHelper
  def program_path program
    "/users/#{program.author_username}/programs/#{program.slug}"
  end
end
