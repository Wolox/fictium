module Fictium
  module Postman
    class V2Exporter
      class ActionFormatter
        def format(action)
          metadata_formatter.format(action, build_base(action))
        end

        private

        def build_base(action)
          {
            id: "#{action.method} - #{action.full_path}",
            name: action.summary,
            description: action.description,
            request: request_formatter.format(action.default_example),
            response: format_responses(action)
          }
        end

        def format_responses(action)
          result = action.examples.map { |example| response_formatter.format(example) }
          result.reject(&:blank?)
        end

        def request_formatter
          @request_formatter ||= RequestFormatter.new
        end

        def response_formatter
          @response_formatter ||= ResponseFormatter.new
        end

        def metadata_formatter
          @metadata_formatter ||= MetadataFormatter.new
        end
      end
    end
  end
end
