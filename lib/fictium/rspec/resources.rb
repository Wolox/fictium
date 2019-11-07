module Fictium
  module RSpec
    module Resources
      extend ActiveSupport::Concern

      included do
        metadata[:fictium_resource] = Fictium::RSpec.document.create_resource
        Fictium::RSpec::Autocomplete::Resource.name_attributes(
          metadata[:fictium_resource],
          metadata[:described_class].name
        )
      end

      class_methods do
        def action(*args, **kwargs)
          Fictium::RSpec::Proxies::Action.new(self, args, kwargs)
        end

        def base_path(path)
          metadata[:fictium_resource].base_path = path
        end

        def resource_name(name)
          metadata[:fictium_resource].name = name
        end

        def resource_summary(summary)
          metadata[:fictium_resource].summary = summary
        end

        def resource_description(description)
          metadata[:fictium_resource].description = description
        end

        def resource_tags(*tags)
          metadata[:fictium_resource].tags += tags
        end
      end
    end
  end
end
