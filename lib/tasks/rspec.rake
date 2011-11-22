RSpec::Core::RakeTask.new(:spec_lolz) do |spec|
  spec.rspec_opts = ["-r./spec/spec_helper.rb"]
end

