module ApplicationHelper
  def username_program_slug_path username, program_slug
    "/users/#{username}/programs/#{program_slug}"
  end

  def username_path username
    "/users/#{username}"
  end
end
