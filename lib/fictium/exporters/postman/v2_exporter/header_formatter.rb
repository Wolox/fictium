module Fictium
  module Postman
    class V2Exporter
      class HeaderFormatter
        def format(http_subject)
          [].tap do |header|
            content = http_subject[:content_type]
            header << { key: 'Content-Type', value: content } if content.present?
            # TODO: Add the rest of the headers
          end
        end
      end
    end
  end
end
