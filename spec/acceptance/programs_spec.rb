require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Programs" do

  scenario "can be created" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/programs/new"
    fill_in "Title", :with => "Hello world"
    fill_in "Body", :with => "puts 'Hello, world!'"
    click_button "Create"

    should_be_on "#{@hacker.username}/hello_world"

    page.should have_content "Program created"
    page.should have_content "Hello world"
    page.should have_content "By steve"
    page.should have_content "puts"

  end

  scenario "can be seen on my page" do
    @hacker = Factory(:hacker)
    log_in @hacker

    (rand(5) + 1).times do |n|
      @hacker.programs << Factory(:program)
    end

    visit "/hackers/#{@hacker.username}"
    page.should have_content "Programs"

    @hacker.programs.each do |program|
      page.should have_content program.title
    end
  end

  describe "has comments" do
    scenario "can't be commented on when not logged in" do
      @hacker = Factory(:hacker)

      program = Factory(:program, :creator_username => @hacker.username)

      visit "/programs/#{@hacker.slug}/#{@hacker.programs.first.slug}"
      page.should_not have_content "Add a comment"
    end

    scenario "can be commented on when you are logged in" do
      @hacker = Factory(:hacker)
      log_in @hacker

      program = Factory(:program, :creator_username => @hacker.username)

      visit "/programs/#{@hacker.slug}/#{@hacker.programs.first.slug}"
      page.should have_content "Add a comment"
    end
  end
end
