Rake.application.instance_variable_get('@tasks').delete('spec')

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-r./spec/spec_helper.rb"]
end

