module Fictium
  module Postman
    class V2Exporter
      class ActionFormatter
        def format(action)
          {
            id: action.full_path,
            name: action.summary,
            description: action.description,
            request: request_formatter.format(action),
            response: response_formatter.format(action)
          }
        end

        private

        def request_formatter
          @request_formatter ||= RequestFormatter.new
        end

        def response_formatter
          @response_formatter ||= ResponseFormatter.new
        end
      end
    end
  end
end
