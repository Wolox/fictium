module Fictium
  class ApiBlueprintExporter
    class ExampleFormatter < Fictium::ApiBlueprintExporter::BaseFormatter
      protected

      def format_sections(example)
        [format_request(example), format_response(example)]
      end

      private

      def format_request(example)
        return '' if example.try(:request).blank?
        return '' if example.request[:body].blank?

        result = request_head(example)
        result += "\n  #{example.description}\n" if example.description.present?
        result += parse_http_object(example.request)
        result
      end

      def format_response(example)
        return '' if example.try(:response).blank?

        result = response_head(example)
        result += parse_http_object(example.response)
        result
      end

      def parse_http_object(http_object)
        "#{parse_header(http_object[:header])}#{parse_body(http_object)}"
      end

      def parse_header(header)
        return '' if header.blank?

        mapped_headers = header.map do |key, value|
          "            #{key}: #{value}"
        end
        <<~HEREDOC
          \x20
            + Header

          #{mapped_headers.join("\n")}
        HEREDOC
      end

      def request_head(example)
        "+ Request #{example.summary} \n"
      end

      def response_head(example)
        "+ Response #{example.response[:status]} (#{example.response[:content_type]})\n"
      end

      def parse_body(http_element)
        return "\n  + Body" if http_element[:body].blank?

        <<~HEREDOC
          \x20
            + Body

                ```
                #{http_element[:body]}
                ```
        HEREDOC
      end
    end
  end
end
