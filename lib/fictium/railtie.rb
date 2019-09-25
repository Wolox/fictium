module Fictium
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir[File.join(__dir__, '..', '..', 'tasks', '**', '*.rake')].each do |f|
        load f
      end
    end
  end
end
