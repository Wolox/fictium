ENV['RAILS_ENV'] = 'development'

require 'bundler/setup'

# Load GEM dependencies first
Bundler.require(:development, :test)

require 'rails/config/environment'
require 'rails/config/routes'

require 'rspec/rails'

SimpleCov.start

# Load default config (fictium included!)
Bundler.require(:default)

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess

  config.infer_spec_type_from_file_location!

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
