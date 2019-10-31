module Fictium
  module Postman
    class V2Exporter
      class ItemFormatter
        def format(document)
          document.resources.map do |resource|
            folder_formatter.format(self, resource)
          end
        end

        def from_resource(resource)
          resource.actions.map do |action|
            action_formatter.format(action)
          end
        end

        private

        def folder_formatter
          @folder_formatter ||= FolderFormatter.new
        end

        def action_formatter
          @action_formatter ||= ActionFormatter.new
        end
      end
    end
  end
end
