require 'spec_helper'

describe "testing if clickable image exists on login page" do
  
    it "should have image 'twitter_32.png' on the page" do
      
      visit 'http://localhost:3000/login'
     #find(:xpath, "//a/img[@alt='twitter logo']/..").click
     #page.has_xpath?("//a/img[@alt='twitter logo']/..")
     click_on('twitter image') 
      
    #end
  end
end
