require_relative 'v2_exporter/action_formatter'

require_relative 'v2_exporter/info_formatter'
require_relative 'v2_exporter/item_formatter'
require_relative 'v2_exporter/metadata_formatter'

require_relative 'v2_exporter/folder_formatter'

require_relative 'v2_exporter/request_formatter'
require_relative 'v2_exporter/response_formatter'
require_relative 'v2_exporter/header_formatter'
require_relative 'v2_exporter/body_formatter'

module Fictium
  module Postman
    class V2Exporter
      def export(document)
        result = format_document(document)
        validate!(result)
        FileUtils.mkdir_p(File.dirname(export_file))
        File.write(export_file, pretty_print? ? JSON.pretty_generate(result) : result.to_json)
      end

      private

      def export_file
        @export_file ||=
          File.join(Fictium.configuration.export_path, 'postman', '2.1.0', 'collection.json')
      end

      def validate!(result)
        JSON::Validator.validate!(schema, result)
      end

      def schema
        @schema ||= JSON.parse(File.read(File.join(__dir__, 'schemas', '2.1.0.json')))
      end

      def pretty_print?
        Fictium.configuration.pretty_print
      end

      def format_document(document)
        data = { info: info_formatter.format(document), item: item_formatter.format(document) }
        metadata_formatter.format(document, data)
      end

      def metadata_formatter
        @metadata_formatter ||= MetadataFormatter.new
      end

      def info_formatter
        @info_formatter ||= InfoFormatter.new
      end

      def item_formatter
        @item_formatter ||= ItemFormatter.new
      end
    end
  end
end
