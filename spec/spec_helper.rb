ENV['RAILS_ENV'] = 'test'

require 'bundler/setup'

# Load GEM dependencies first
Bundler.require(:development, :test)

require 'rails/config/environment'
require 'rails/config/routes'

require 'rspec/rails'

require_relative 'support/shared_contexts'
require_relative 'support/shared_examples'

SimpleCov.start

# Load default config (fictium included!)
Bundler.require(:default)

# Fictium's official RSpec integration
require 'fictium/rspec'

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess

  config.infer_spec_type_from_file_location!

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Fictium.configure do |config|
  config.fixture_path = File.join(__dir__, 'support', 'docs')

  config.info.terms_of_service = 'https://mytermsofservice.com'
  config.info.license = { name: 'Apache-2.0', url: 'https://www.apache.org/licenses/LICENSE-2.0' }

  config.exporters << Fictium::ApiBlueprintExporter.new
  config.exporters << Fictium::Postman::V2Exporter.new
end
