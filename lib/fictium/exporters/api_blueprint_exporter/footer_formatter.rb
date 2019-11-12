module Fictium
  class ApiBlueprintExporter
    class FooterFormatter < Fictium::ApiBlueprintExporter::BaseFormatter
      delegate :configuration, to: :Fictium
      delegate :info, :api_blueprint, to: :configuration
      delegate :api_version_formatter, :terms_of_service_formatter, :license_formatter,
               to: :api_blueprint

      def format(document)
        list = super(document)
        list.present? ? "# #{api_blueprint.footer_header}\n\n#{list}" : ''
      end

      protected

      def format_sections(_document)
        [
          api_version_reference,
          terms_of_service_reference,
          license_reference
        ]
      end

      private

      def api_version_reference
        return '' if info.version.blank?

        api_version_formatter.call(info.version)
      end

      def terms_of_service_reference
        return '' if info.terms_of_service.blank?

        terms_of_service_formatter.call(info.terms_of_service)
      end

      def license_reference
        info.license.present? ? license_formatter.call(info.license) : ''
      end
    end
  end
end
