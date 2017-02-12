require 'rspec/core/rake_task'

task :default => :spec

desc "run tests for this section"
RSpec::Core::RakeTask.new do |task|
  section = Rake.application.original_dir
  task.pattern = "#{section}/*_spec.rb"
  task.rspec_opts = ["-I#{section}", '-f documentation', '-r ./rspec_config']
  task.verbose = false
end