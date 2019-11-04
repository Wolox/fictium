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
              content_type: response.content_type,
              header: filter_header(response.header.to_h)
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
            example.request.merge!(process_base_request(request))
            extract_method(example, request)
            return unless example.default?

            autocomplete_params.extract_from_request(example.action, request)
          end

          def process_base_request(request)
            {
              content_type: request.content_type,
              body: request.body.string,
              header: filter_header(request.headers.to_h),
              path_parameters: request.path_parameters.except(:controller, :action),
              query_parameters: request.query_parameters
            }
          end

          def extract_method(example, request)
            action = example.action
            action.method = request.method.downcase.to_sym if action.method.blank?
          end

          def filter_header(header)
            valid_keys = header.keys.select { |name| valid_header?(name) }
            header.slice(*valid_keys).transform_keys do |key|
              (key.start_with?('HTTP_') ? key.sub('HTTP_', '') : key).sub('_', '-')
            end
          end

          def valid_header?(name)
            downcase_name = name.downcase
            out_of_header_group?(downcase_name) && out_of_excluded_headers?(downcase_name)
          end

          def out_of_header_group?(name)
            ignored_header_groups.none? { |group| name.start_with?(group) }
          end

          def out_of_excluded_headers?(name)
            Fictium.configuration.ignored_header_values.exclude?(name)
          end

          def ignored_header_groups
            Fictium.configuration.ignored_header_groups
          end
        end
      end
    end
  end
end
