# Use core extensions on this gem
require 'active_support'

# JSON Schema validators
require 'json-schema'

# Core functionalities
require_relative 'fictium/version'

# Load all objects
require 'fictium/loader'

# Load Rails specific parts
if defined?(Rails)
  require 'fictium/railtie'
  require 'fictium/engine'
end

module Fictium
  class << self
    def configuration
      @configuration ||= Fictium::Configuration.new
    end

    def configure
      yield configuration
    end

    def validate_config!
      raise missing_fixtures if configuration.fixture_path.blank?
    end

    private

    def missing_fixtures
      <<~HEREDOC
        Fictium requires to configure your fixture_path first in order to run Fictium.

        Add the following lines into your rails_helper.rb:

        Fictium.configure do |config|
          config.fixture_path = File.join(__dir__, 'support', 'docs')
        end
      HEREDOC
    end
  end
end
