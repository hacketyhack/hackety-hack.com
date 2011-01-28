def should_be_on(path)
  page.current_url.should match(Regexp.new(path))
end

def should_not_be_on(path)
  page.current_url.should_not match(Regexp.new(path))
end

def log_in(hacker)
  visit "/login"
  fill_in "username", :with => hacker.username
  fill_in "password", :with => hacker.password
  click_button "Log in"
end
