module Fictium
  module Postman
    class V2Exporter
      class InfoFormatter
        POSTMAN_SCHEMA_URL = 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'.freeze

        delegate :configuration, to: :Fictium
        delegate :info, :postman, to: :configuration

        def format(_document)
          base_info.tap do |result|
            result[:_postman_id] = postman.id if postman.id.present?
            result[:description] = info.description if info.description.present?
            result[:schema] = POSTMAN_SCHEMA_URL
          end
        end

        private

        def base_info
          { name: info.title, version: info.version }
        end
      end
    end
  end
end
