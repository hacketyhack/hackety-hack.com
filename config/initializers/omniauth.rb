puts "builder: #{require 'omniauth/builder'}", OmniAuth::Builder #"  

Rails.application.config.middleware.use OmniAuth::Builder do |variable|
  #provider :developer unless Rails.env.production?

  provider :twitter, ENV['HH_TWITTER_KEY'], ENV['HH_TWITTER_SECRET']
  provider :github, ENV['HH_GITHUB_KEY'], ENV['HH_GITHUB_SECRET']
  provider :facebook, ENV['HH_FB_KEY'], ENV['HH_FB_SECRET']
  provider :linkedin, ENV['HH_LI_KEY'], ENV['HH_LI_SECRET']
  provider :yahoo, ENV['HH_YAHOO_KEY'], ENV['HH_YAHOO_SECRET']
# provider :google, ENV['HH_GOOGLE_KEY'], ENV['HH_GOOGLE_SECRET']
# PROVIDER :openid, ENV['HH_OPID_KEY'], ENV['HH_OPID_SECRET']   

end 