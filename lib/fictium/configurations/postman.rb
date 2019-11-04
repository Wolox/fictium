module Fictium
  class Configuration
    class Postman
      attr_accessor :id, :api_url

      def initialize
        @api_url = '{{API_URL}}'
      end
    end
  end
end
