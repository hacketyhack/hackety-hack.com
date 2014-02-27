Given(/^"(.*?)" user agent$/) do |agent|
  page.driver.header('User-Agent', agent)
end

Then(/^I should be able to download "(.*?)" software$/) do |system|
  visit download_path
  page.should have_content("Version 1.0.1 for #{system}")
end