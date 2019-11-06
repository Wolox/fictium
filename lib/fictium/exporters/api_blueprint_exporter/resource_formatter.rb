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
        header += "\n#{resource.description}\n" if resource.description.present?
        header
      end

      def build_actions(resource)
        resource.actions.map do |action|
          action_formatter.format(action)
        end.select(&:present?).join("\n\n")
      end

      def action_formatter
        @action_formatter ||= ActionFormatter.new
      end
    end
  end
end
