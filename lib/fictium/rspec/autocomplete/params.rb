module Fictium
  module RSpec
    module Autocomplete
      module Params
        REQUEST_SECTIONS = %i[query header path cookie].freeze
        IGNORED_PATH_PARAMETERS = %i[action controller].freeze

        class << self
          include Rails.application.routes.url_helpers

          def extract_from_request(action, request)
            extract_path(action, request)
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

          def extract_path(action, request)
            return unless action.path.nil?

            mapped_controllers = transform_path(request)
            full_path = CGI.unescape(url_for(**mapped_controllers.merge(only_path: true)))
            action.path = full_path.sub(action.resource.base_path || '', '')
          end

          def transform_path(request)
            {}.tap do |result|
              request.path_parameters.except(*IGNORED_PATH_PARAMETERS).each do |key, _|
                result[key] = "{#{key}}"
              end
              request.path_parameters.slice(*IGNORED_PATH_PARAMETERS).each do |key, value|
                result[key] = value
              end
            end
          end

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

          def parse_request_path(params, _action, request)
            request.path_parameters.except(*IGNORED_PATH_PARAMETERS).each do |name, value|
              params[name] ||= {}
              params[name].merge!(
                example: value
              )
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
        end
      end
    end
  end
end
