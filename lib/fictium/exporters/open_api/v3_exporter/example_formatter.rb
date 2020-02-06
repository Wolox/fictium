module Fictium
  module OpenApi
    class V3Exporter
      class ExampleFormatter
        def format_default(operation, responses, default_example)
          responses[:default] = format(default_example)
          return if default_example.request[:content_type].blank?

          return unless valid_request_body?(default_example.request[:body])

          operation[:requestBody] = {
            content: content_formatter.format(default_example.request)
          }
          operation[:requestBody][:required] = true if default_example.request[:required]
        end

        def format(example)
          { description: example.summary }.tap do |format|
            content = content_formatter.format(example.response, default_response_content_type)
            format[:content] = content if content.present?
            headers = extract_headers(example)
            format[:headers] = headers if headers.present?
          end
        end

        def default_response_content_type
          Fictium.configuration.default_response_content_type
        end

        def extract_headers(example)
          {}.tap do |headers|
            example.headers.each do |name, value|
              headers[name] = header_formatter.format(name, :header, value)
            end
          end
        end

        def content_formatter
          @content_formatter ||= ContentFormatter.new
        end

        def header_formatter
          @header_formatter ||= ParamFormatter.new(ignore_name: true, ignore_in: true)
        end

        private

        def valid_request_body?(request_body)
          request_body.present? && JSON.parse(request_body).present?
        end
      end
    end
  end
end
