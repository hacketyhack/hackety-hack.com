# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the new hacker page/
      "/signup"
    when /the main page/
      "/"
    when /the hacker page for "(.*)"/
      "/hackers/#{$1}"
    when /my messages page/
      "/messages"
    when /the new program page/
      "/programs/new"
    when /the "(.*)" program page/
      "/programs/#{$1}"
    when /the forums/
      "/forums"
    when /the forum "(.*)"/
      "/forums/#{$1}"
    when /the discussion "(.*)" in "(.*)"/
      "/forums/#{$2}/#{$1}"
    when /the discussion/
      "/forums/#{@discussion.forum}/#{@discussion.slug}"
    when /the help page/
      "/help"
    when /the github page/
      "/hacketyhack/hacketyhack/"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
