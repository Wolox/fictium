require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

Dir[File.join(__dir__, 'tasks', '**', '*.rake')].each do |f|
  require f
end

task default: :spec
