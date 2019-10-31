require_relative 'v2_exporters/info_formatter'
require_relative 'v2_exporters/item_formatter'
require_relative 'v2_exporters/event_formatter'
require_relative 'v2_exporters/variable_formatter'
require_relative 'v2_exporters/auth_formatter'
require_relative 'v2_exporters/protocol_formatter'

require_relative 'v2_exporters/folder_formatter'

require_relative 'v2_exporters/request_formatter'
require_relative 'v2_exporters/response_formatter'

module Fictium
  module Postman
    class V2Exporter
      OPTIONAL_KEYS = %w[event variable auth protocol_profile_behavior].freeze

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
        data.tap do |result|
          OPTIONAL_KEYS.each do |key|
            result = send(:"#{key}_formatter", document)
            data[key.camelize(:lower)] = result if result.present?
          end
        end
      end

      def info_formatter
        @info_formatter ||= InfoFormatter.new
      end

      def item_formatter
        @item_formatter ||= ItemFormatter.new
      end

      def event_formatter
        @event_formatter ||= EventFormatter.new
      end

      def variable_formatter
        @variable_formatter ||= VariableFormatter.new
      end

      def auth_formatter
        @auth_formatter ||= AuthFormatter.new
      end

      def protocol_profile_behavior_formatter
        @protocol_profile_behavior_formatter ||= ProtocolFormatter.new
      end
    end
  end
end
