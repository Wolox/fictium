module Fictium
  module RSpec
    module Autocomplete
      module Resource
        CONTROLLER_TERMINATION = /Controller$/.freeze

        class << self
          def name_attributes(resource, controller_name)
            resource_path = controller_name.sub(CONTROLLER_TERMINATION, '').underscore
            resource.base_path = "/#{resource_path}"
            path_sections = resource_path.split('/')
            plural = path_sections.last
            resource.name = plural.singularize.humanize(capitalize: false)
            resource.summary = Fictium.configuration.summary_format.call(plural)
          end
        end
      end
    end
  end
end
