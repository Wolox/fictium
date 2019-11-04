module Fictium
  module Postman
    class V2Exporter
      class MetadataFormatter
        FIELDS = %i[event variable auth].freeze

        def format(subject, result)
          FIELDS.each do |field|
            value = subject.postman.public_send(field)
            result[field] = value if value.present?
          end
          result
        end
      end
    end
  end
end
