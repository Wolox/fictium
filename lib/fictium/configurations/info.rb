module Fictium
  class Configuration
    class Info
      attr_accessor :title, :description, :terms_of_service, :contract, :license, :version

      def initialize
        self.title = 'TODO: Change me at Fictium.configuration.api'
        self.version = '0.1.0'
      end
    end
  end
end
