module Fictium
  module RSpec
    module Autocomplete
      module Params
        REQUEST_SECTIONS = %i[query header path cookie].freeze
        PATH_TEMPLATE = /{([A-Z_\-][A-Z0-9_\-]*)}/i.freeze

        class << self
          def extract_from_request(action, request)
            REQUEST_SECTIONS.each do |section|
              action.params[section] ||= ActiveSupport::HashWithIndifferentAccess.new
              send(:"parse_request_#{section}", action.params[section], action, request)
            end
          end

          def extract_from_response(example, response)
            example.headers ||= ActiveSupport::HashWithIndifferentAccess.new
            response.headers.each do |name, value|
              next unless valid_header?(name)

              example.headers[name] ||= {}
              example.headers[name].merge!(
                example: value
              )
            end
          end

          private

          def parse_request_query(params, _action, request)
            request.query_parameters.each do |key, value|
              params[key] ||= {}
              params[key].merge!(
                example: value
              )
            end
          end

          def parse_request_header(params, _action, request)
            request.headers.to_h.each do |name, value|
              next unless valid_header?(name)

              params[name] ||= {}
              params[name].merge!(
                example: value
              )
            end
          end

          def parse_request_path(params, action, _request)
            action.full_path.scan(PATH_TEMPLATE).flatten.each do |name|
              params[name] ||= {}
              # TODO: Extract example from request
            end
          end

          def parse_request_cookie(params, _action, request)
            request.cookies.each do |key, value|
              params[key] ||= {}
              params[key].merge!(
                example: value
              )
            end
          end

          def valid_header?(name)
            return false if ignored_header_groups.any? { |group| name.downcase.start_with?(group) }

            !Fictium.configuration.ignored_header_values.include?(name.downcase)
          end

          def ignored_header_groups
            Fictium.configuration.ignored_header_groups
          end

          private

          def parse_request_query(params, _action, request)
            parse_query_values(request.query_string).each do |key, value|
              params[key] ||= {}
              params[key].merge!(
                example: value
              )
            end
          end

          def parse_request_header(params, _action, request)
            request.headers.to_h.each do |name, value|
              next unless valid_header?(name)

              params[name] ||= {}
              params[name].merge!(
                example: value
              )
            end
          end

          def parse_request_path(params, action, _request)
            action.full_path.scan(PATH_TEMPLATE).flatten.each do |name|
              params[name] ||= {}
              # TODO: Extract example from request
            end
          end

          def parse_request_cookie(params, _action, request)
            request.cookies.each do |key, value|
              params[key] ||= {}
              params[key].merge!(
                example: value
              )
            end
          end

          def valid_header?(name)
            return false if ignored_header_groups.any? { |group| name.downcase.start_with?(group) }

            !Fictium.configuration.ignored_header_values.include?(name.downcase)
          end

          def ignored_header_groups
            Fictium.configuration.ignored_header_groups
          end

          def parse_query_values(query_string)
            if defined?(Rack::Utils)
              Rack::Utils.parse_nested_query(query_string.presence || '')
            else
              CGI.parse(query_string.presence || '')
            end
          end
        end
      end
    end
  end
end
