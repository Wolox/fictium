module Fictium
  class ApiBlueprintExporter
    class ResourceFormatter < Fictium::ApiBlueprintExporter::BaseFormatter
      protected

      def format_sections(resource)
        [build_header(resource), build_actions(resource)]
      end

      private

      def build_header(resource)
        header = "# #{resource.name&.pluralize&.humanize} [#{resource.base_path}]"
        header += "\n#{resource.summary.capitalize}\n" if resource.summary.present?
        description = resource.description.present? ? "\n#{resource.description}\n" : ''
        "#{header}#{description}"
      end

      def build_actions(resource)
        sections = resource.actions.map do |action|
          action_formatter.format(action)
        end
        join_sections(sections)
      end

      def action_formatter
        @action_formatter ||= ActionFormatter.new
      end
    end
  end
end
