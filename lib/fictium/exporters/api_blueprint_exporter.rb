require_relative 'api_blueprint_exporter/base_formatter'

require_relative 'api_blueprint_exporter/header_formatter'
require_relative 'api_blueprint_exporter/resource_formatter'
require_relative 'api_blueprint_exporter/action_formatter'
require_relative 'api_blueprint_exporter/example_formatter'
require_relative 'api_blueprint_exporter/footer_formatter'

module Fictium
  class ApiBlueprintExporter
    def export(document)
      result = process_file(document).presence || ''
      FileUtils.mkdir_p(File.dirname(export_file))
      File.write(export_file, result)
    end

    private

    def process_file(document)
      list = [build_header(document), build_footer(document), build_resources(document)]
      clean_items(list)
    end

    def export_file
      @export_file ||=
        File.join(Fictium.configuration.export_path, 'api_blueprint', 'api.apib')
    end

    def build_header(document)
      header_formatter.format(document)
    end

    def build_resources(document)
      mapped_resources = document.resources.map do |resource|
        resource_formatter.format(resource)
      end
      mapped_resources = clean_items(mapped_resources)
      mapped_resources.present? ? "# Group #{resources_group_name} \n\n#{mapped_resources}" : ''
    end

    def build_footer(document)
      footer_formatter.format(document)
    end

    def header_formatter
      HeaderFormatter.new
    end

    def resource_formatter
      @resource_formatter ||= ResourceFormatter.new
    end

    def footer_formatter
      FooterFormatter.new
    end

    def resources_group_name
      Fictium.configuration.api_blueprint.resources_group_name
    end

    def clean_items(items)
      items.select(&:present?).join("\n\n")
    end
  end
end
