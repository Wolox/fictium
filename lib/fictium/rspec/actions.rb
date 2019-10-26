module Fictium
  module RSpec
    module Actions
      extend ActiveSupport::Concern

      included do
        metadata[:fictium_action] = metadata[:fictium_resource].create_action
        metadata[:fictium_action].description_attributes(metadata[:description])
      end

      class_methods do
        def path(path)
          metadata[:fictium_action].path = path
        end

        def params_in(section, &block)
          metadata[:fictium_action].add_params_in(section, &block)
        end

        def example(*args, **kwargs)
          Fictium::RSpec::Proxies::Example.new(self, args, kwargs)
        end

        def deprecate!
          metadata[:fictium_action].deprecated = true
        end
      end
    end
  end
end
