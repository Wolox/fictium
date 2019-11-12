module Fictium
  class ApiBlueprintExporter
    class ActionFormatter < Fictium::ApiBlueprintExporter::BaseFormatter
      protected

      def format_sections(action)
        [build_header(action), build_examples(action)]
      end

      private

      def build_header(action)
        result = "## #{action.summary} [#{action.method.to_s.upcase} #{action.path}]"
        "#{result}#{action.description.present? ? "\n\n#{action.description}\n" : ''}"
      end

      def build_examples(action)
        default_example = action.default_example
        examples = action.examples.reject { |example| example == default_example }
        sections = ([default_example] + examples).map do |example|
          example_formatter.format(example)
        end
        join_sections(sections)
      end

      def example_formatter
        @example_formatter ||= ExampleFormatter.new
      end
    end
  end
end
