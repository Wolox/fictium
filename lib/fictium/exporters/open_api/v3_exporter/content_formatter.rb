module Fictium
  module OpenApi
    class V3Exporter
      class ContentFormatter
        def format(http_object, default = nil)
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
      end
    end
  end
end
