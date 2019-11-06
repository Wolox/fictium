module Fictium
  module OpenApi
    class V3Exporter
      class PathGenerator
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def generate
          {}.tap do |paths|
            document.resources.each do |resource|
              generate_from_resource(paths, resource)
            end
          end
        end

        private

        def generate_from_resource(paths, resource)
          resource.actions.each do |action|
            generate_from_action(paths, action)
          end
        end

        def generate_from_action(paths, action)
          path_formatter.add_path(paths, action)
        end

        def path_formatter
          @path_formatter ||= PathFormatter.new
        end
      end
    end
  end
end
