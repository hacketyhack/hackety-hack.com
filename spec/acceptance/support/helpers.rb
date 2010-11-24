def should_be_on(path)
  page.current_url.should match(Regexp.new(path))
end

def should_not_be_on(path)
  page.current_url.should_not match(Regexp.new(path))
end
