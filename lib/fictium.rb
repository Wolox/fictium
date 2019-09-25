# Use core extensions on this gem
require 'active_support'

# Core functionalities
require_relative 'fictium/version'

if defined?(Rails)
  require 'fictium/railtie'
  require 'fictium/engine'
else
  require 'fictium/no_autoload'
end
