module Fictium
  module Postman
    class V2Exporter
      class RequestFormatter
        PATH_VARIABLE = /{(?<var>[A-Z_\-][A-Z0-9_\-]*)}/i.freeze

        def format(action)
          example = action.default_example
          {}.tap do |result|
            result.merge!(
              url: format_url(example),
              method: action.method.to_s.downcase,
              description: action.description,
              header: format_header(example)
            )
            add_optional_values(example, result)
          end
        end

        private

        def format_url(example)
          {
            raw: full_path(example),
            host: [api_url],
            path: format_path(example),
            query: format_query(example),
            variable: format_variable(example)
          }
        end

        def full_path(example)
          "#{api_url}#{convert_path(example.action)}#{query_params_for(example)}"
        end

        def convert_path(action)
          action.full_path.gsub(PATH_VARIABLE, ':\k<var>')
        end

        def format_path(example)
          path = convert_path(example.action).split('/')
          path.shift
          path
        end

        def query_params_for(example)
          params = example.request[:query_parameters]
          params.present? ? "?#{params.to_query}" : ''
        end

        def api_url
          Fictium.configuration.postman.api_url
        end

        def format_query(example)
          example.request[:query_parameters].map do |key, value|
            result = { key: key, value: value }
            description = example.action[:query][key] && example.action[:query][key][:description]
            result[:description] = description if description.present?
            result
          end
        end

        def format_variable(example)
          [].tap do |result|
            example.action[:path].each do |name, _|
              data = { id: name, key: name }
              value = example.request[:path_parameters][name.to_sym]
              data[:value] = value if value.present?
              result << data
            end
          end
        end

        def add_optional_values(example, result)
          body = format_body(example)
          result[:body] = body if body.present?
        end

        def format_header(example)
          [].tap do |header|
            header << { key: 'Content-Type', value: example.request[:content_type] }
            # TODO: Add the rest of the headers
          end
        end

        def format_body(example)
          body = example.request[:body]
          return if body.blank?

          { mode: 'raw', raw: body }
        end
      end
    end
  end
end
