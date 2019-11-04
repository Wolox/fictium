module Fictium
  module Postman
    class V2Exporter
      class FolderFormatter
        def format(item_formatter, resource)
          { name: resource.name }.tap do |result|
            result[:description] = format_description(resource)
            result[:item] = item_formatter.from_resource(resource)
            metadata_formatter.format(resource, result)
          end
        end

        private

        def format_description(resource)
          return resource.description if resource.description.present?

          resource.summary
        end

        def metadata_formatter
          @metadata_formatter ||= MetadataFormatter.new
        end
      end
    end
  end
end
