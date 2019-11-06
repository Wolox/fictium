module Fictium
  module RSpec
    module Autocomplete
      module Example
        class << self
          def process_http_response(example, response)
            example.response ||= {}
            example.response.merge!(
              status: response.status,
              body: response.body,
              content_type: response.content_type
            )
            process_http_request(example, response.request)
            return unless example.default?

            autocomplete_params.extract_from_response(example, response)
          end

          private

          def autocomplete_params
            Fictium::RSpec::Autocomplete::Params
          end

          def process_http_request(example, request)
            example.request ||= {}
            example.request.merge!(
              content_type: request.content_type,
              body: request.body.string
            )
            extract_method(example, request)
            return unless example.default?

            autocomplete_params.extract_from_request(example.action, request)
          end

          def extract_method(example, request)
            action = example.action
            action.method = request.method.downcase.to_sym if action.method.blank?
          end
        end
      end
    end
  end
end
