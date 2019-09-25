module Fictium
  class Engine < Rails::Engine
    engine_name 'fictium'
    isolate_namespace Fictium

    config.autoload_paths << __dir__
  end
end
