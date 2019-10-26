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
          {}.tap do |operation|
            operation[:tags] = action.combined_tags
            operation[:description] = action.summary
            operation[:parameters] = format_parameters(action)
            operation[:responses] = format_responses(operation, action)
            operation[:deprecated] = action.deprecated?
          end
        end

        def format_parameters(_action)
          [] # TODO: Improve parameters
        end

        def format_responses(operation, action)
          {}.tap do |responses|
            default_example = action.default_example
            break if default_example.blank?

            format_default_example(operation, responses, default_example)
            other_examples = action.examples.reject { |example| example == default_example }
            other_examples.each do |example|
              responses[example.response[:status]] = format_example(example)
            end
          end
        end

        def format_default_example(operation, responses, default_example)
          responses[:default] = format_example(default_example)
          return if default_example.request[:content_type].blank?

          operation[:requestBody] = {
            content: format_content(default_example.request)
          }
          operation[:requestBody][:required] = true if default_example.request[:required]
        end

        def format_example(example)
          { description: example.summary }.tap do |format|
            content = format_content(example.response, default_response_content_type)
            format[:content] = content if content.present?
          end
        end

        def format_content(http_object, default = nil)
          type = (http_object.presence && http_object[:content_type].presence) || default
          return if type.blank?

          {}.tap do |content|
            media_type = {
              example: http_object[:body]
            }
            media_type[:schema] = http_object[:schema] if http_object[:schema].present?
            content[type.to_sym] = media_type
          end
        end

        def default_response_content_type
          Fictium.configuration.default_response_content_type
        end
      end
    end
  end
end
