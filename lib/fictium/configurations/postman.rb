module Fictium
  class Configuration
    class Postman
      attr_accessor :id, :api_url, :default_status_names, :unknown_status_name, :example_formatter

      def initialize
        @api_url = '{{API_URL}}'
        @example_formatter = method(:format_example)
        @default_status_names = {}
        @unknown_status_name = method(:format_unknown_status_name)
      end

      private

      def format_example(status, example)
        "[#{status}] #{status_name_for(status, example)}"
      end

      def status_name_for(status, example)
        method = default_status_names[status] || unknown_status_name
        method.call(status, example)
      end

      def format_unknown_status_name(_status, example)
        example.summary
      end
    end
  end
end
