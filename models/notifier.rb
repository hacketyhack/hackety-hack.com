# This class handles sending emails. Everything related to it should go in
# here, that way it's just as easy as
# `Notifier.send_message_notification(me, you)` to send a message.
class Notifier 
  def self.send_message_notification(recipient, who)
    Pony.mail(:to => recipient, 
              :subject => "Hackety Hack: New Message",
              :from => "steve+hackety@steveklabnik.com",
              :body => render_haml_template("message", who),
              :via => :smtp, :via_options => PONY_VIA_OPTIONS)
  end

  private

  # This was kinda crazy to figure out. We have to make our own instantiation
  # of the Engine, and then set local variables. Crazy.
  def self.render_haml_template(template, who)
    engine = Haml::Engine.new(File.open("views/notifier/#{template}.haml", "rb").read)
    engine.render(Object.new, :who => who)
  end
end

