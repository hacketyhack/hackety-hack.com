class Notification < ActionMailer::Base
  default from: "steve@hackety.com"
  default_url_options[:host] = "hackety.com"

  def new_answer(question)
    @question = question
    @url = question_url(question, :host => "hackety.com")
    mail(:to => question.user.email, :subject => "New Answer on Hackety.com!")
  end
end
