module Fictium
  module Postman
    class V2Exporter
      class ResponseFormatter
        def format(example)
          base_info_for(example).tap do |result|
            body = body_formatter.format(example.response, response: true)
            header = header_formatter.format(example.response)
            result[:body] = body if body.present?
            result[:header] = header if header.present?
          end
        end

        private

        def base_info_for(example)
          return {} if example.response.blank?

          status = example.response[:status]
          formatted_status = format_status(status, example)
          {
            originalRequest: request_formatter.format(example),
            responseTime: nil,
            status: format_status(status, example),
            name: formatted_status,
            code: status
          }
        end

        def request_formatter
          @request_formatter ||= RequestFormatter.new
        end

        def body_formatter
          @body_formatter ||= BodyFormatter.new
        end

        def header_formatter
          @header_formatter ||= HeaderFormatter.new
        end

        def format_status(status, example)
          postman.example_formatter.call(status, example)
        end

        def postman
          Fictium.configuration.postman
        end
      end
    end
  end
end
