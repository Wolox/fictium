module Fictium
  module Postman
    class V2Exporter
      class BodyFormatter
        def format(http_subject, response: false)
          body = http_subject[:body]
          return if body.blank?
          return body if response

          { mode: 'raw', raw: body }
        end
      end
    end
  end
end
