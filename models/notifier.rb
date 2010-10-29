class Notifier 
  def self.send_message_notification(recipient, who)
    Pony.mail(:to => recipient, 
              :subject => "Hackety Hack: New Message",
              :from => "steve+hackety@steveklabnik.com",
              :body => render_haml_template("message", who),
              :via => :smtp, :via_options => PONY_VIA_OPTIONS)
  end

  private

  def self.render_haml_template(template, who)
    engine = Haml::Engine.new(File.open("views/notifier/#{template}.haml", "rb").read, :who => who)
    engine.render
  end
end

