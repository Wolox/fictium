require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'

require_relative 'errors'

module Fictium
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths += Dir[File.join(File.dirname(__dir__), 'app', '**', '*')]

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
