# Use core extensions on this gem
require 'active_support'

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
  end
end
