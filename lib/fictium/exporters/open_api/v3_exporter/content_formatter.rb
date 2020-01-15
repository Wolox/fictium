module Fictium
  module OpenApi
    class V3Exporter
      class ContentFormatter
        APP_JSON = 'application/json'.freeze

        def format(http_object, default = nil)
          type = (http_object.presence && http_object[:content_type].presence) || default
          return if type.blank?

          {}.tap do |content|
            media_type = {
              example: format_body(http_object[:content_type], http_object[:body])
            }
            media_type[:schema] = http_object[:schema] if http_object[:schema].present?
            content[type.to_sym] = media_type
          end
        end

        protected

        def format_body(content_type, body)
          content_type == APP_JSON && !body.empty? ? JSON.parse(body) : body
        end
      end
    end
  end
end
