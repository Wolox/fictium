module Fictium
  class Configuration
    class ApiBlueprint
      attr_accessor :resources_group_name, :host, :footer_header,
                    :api_version_formatter, :terms_of_service_formatter, :license_formatter

      def initialize
        self.host = 'https://change.me.at.api_blueprint.config'
        self.resources_group_name = 'Resources'
        self.footer_header = 'Information and references'
        self.api_version_formatter = method(:format_api_version)
        self.terms_of_service_formatter = method(:format_terms_of_service)
        self.license_formatter = method(:format_license)
      end

      private

      def format_api_version(api_version)
        "API version: #{api_version}"
      end

      def format_terms_of_service(terms_of_service)
        "[Terms of service](#{terms_of_service})."
      end

      def format_license(license)
        "[#{license[:name]}](#{license[:url]}) license."
      end
    end
  end
end
