require_relative 'v3_exporter/content_formatter'
require_relative 'v3_exporter/example_formatter'
require_relative 'v3_exporter/param_formatter'

require_relative 'v3_exporter/path_formatter'
require_relative 'v3_exporter/path_generator'

module Fictium
  module OpenApi
    class V3Exporter
      DEFAULT_PROPERTIES = {
        openapi: '3.0.0'
      }.freeze
      FIXTURE_TYPES = %w[servers security tags].freeze
      INFO_OPTIONS = %w[title description terms_of_service contract license version].freeze

      def export(document)
        result = DEFAULT_PROPERTIES
                 .merge(create_fixtures)
                 .merge(info: create_info, paths: create_paths(document))
        validate!(result)
        FileUtils.mkdir_p(File.dirname(export_file))
        File.write(export_file, pretty_print? ? JSON.pretty_generate(result) : result.to_json)
      end

      private

      def export_file
        @export_file ||=
          File.join(Fictium.configuration.export_path, 'open_api', '3.0.0', 'swagger.json')
      end

      def create_fixtures
        {}.tap do |fixtures|
          FIXTURE_TYPES.each do |name|
            result = load_fixtures(name)
            fixtures[name.camelize(:lower)] = result if result.present?
          end
        end
      end

      def create_info
        {}.tap do |info|
          INFO_OPTIONS.each do |option|
            value = Fictium.configuration.info.public_send(option)
            info[option.camelize(:lower)] = value if value.present?
          end
        end
      end

      def create_paths(document)
        V3Exporter::PathGenerator.new(document).generate
      end

      def load_fixtures(name)
        fixture_file = File.join(fixture_path, "#{name}.json")
        return unless File.exist?(fixture_file)

        JSON.parse(File.read(fixture_file))
      end

      def fixture_path
        Fictium.configuration.fixture_path
      end

      def validate!(result)
        JSON::Validator.validate!(schema, result)
      end

      def schema
        @schema ||= JSON.parse(File.read(File.join(__dir__, 'schemas', '3.0.0.json')))
      end

      def pretty_print?
        Fictium.configuration.pretty_print
      end
    end
  end
end
