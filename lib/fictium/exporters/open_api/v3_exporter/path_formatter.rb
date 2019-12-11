module Fictium
  module OpenApi
    class V3Exporter
      class PathFormatter
        def add_path(paths, action)
          return if action.method.blank?

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

        def format_parameters(action)
          [].tap do |result|
            action.params.each do |section, values|
              values.each do |name, data|
                result << param_formatter.format(name, section, data)
              end
            end
          end
        end

        def format_responses(operation, action)
          {}.tap do |responses|
            default_example = action.default_example
            break if default_example.blank?

            example_formatter.format_default(operation, responses, default_example)
            other_examples = action.examples.reject { |example| example == default_example }
            other_examples.each(&method(:format_example))
          end
        end

        def format_example(example)
          return if example.response.blank?

          responses[example.response[:status]] = example_formatter.format(example)
        end

        def example_formatter
          @example_formatter ||= ExampleFormatter.new
        end

        def param_formatter
          @param_formatter ||= ParamFormatter.new
        end
      end
    end
  end
end
