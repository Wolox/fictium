module Fictium
  module OpenApi
    class V3Exporter
      class PathFormatter
        def add_path(paths, action)
          path_object = paths[action.full_path] || default_path_object
          path_object[action.method.to_sym] = create_operation(action)
          paths[action.full_path] = path_object
        end

        private

        def default_path_object
          { description: '' }
        end

        def create_operation(action)
          {
            tags: action.combined_tags,
            description: action.summary,
            parameters: format_parameters(action),
            responses: format_responses(action),
            deprecated: action.deprecated?
          }
        end

        def format_parameters(_action)
          [] # TODO: Improve parameters
        end

        def format_responses(action)
          {}.tap do |responses|
            default_response = action.default_example
            break if default_response.blank?

            responses[:default] = format_response(default_response)
            action.examples.reject { |r| r == default_response }.each do |response|
              responses[response.status_code] = format_response(response)
            end
          end
        end

        def format_response(response)
          {
            description: response.summary,
            content: format_content(response)
          }
        end

        def format_content(response)
          type = response.content_type.presence || Fictium.configuration.default_content_type
          {
            type.to_sym => {
              example: response.response_body
            }
          }
        end
      end
    end
  end
end
