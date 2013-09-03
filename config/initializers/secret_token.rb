if ENV["SECRET_TOKEN"].blank?
  if Rails.env.production?
    raise "You must set ENV[\"SECRET_TOKEN\"] in your app's config vars"
  elsif Rails.env.test?
    # Generate the key and test away
    ENV["SECRET_TOKEN"] = HacketyHackCom::Application.config.secret_token = SecureRandom.hex(30)
  else
    config_file = File.expand_path(File.join(Rails.root, '/config/config.yml'))
    unless File.exist? config_file
      require 'fileutils'
      FileUtils.cp config_file + '.sample', config_file
    end
    config = YAML.load_file(config_file)
    # Generate the key, set it for the current environment, update the yaml file and move on
    ENV["SECRET_TOKEN"] = config[Rails.env]['SECRET_TOKEN'] = SecureRandom.hex(30)
    File.open(config_file, 'w') { |file| file.write(config.to_yaml) }
  end
end


# Be sure to restart your server when you modify this file.

#HacketyHackCom::Application.config.secret_token = '855ad4d9d95703179ef4280cd14ec205cb6a1fb2477c11bdf55d80390a8ecae82e4b60a4d9e572f9a83cd4d74cedf32a0592afdf36fc86aff0da766fa866aafd'
