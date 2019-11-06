require 'fictium'
require 'rspec'
require 'verbs'

require_relative 'rspec/proxy_handler'

require_relative 'rspec/resources'
require_relative 'rspec/actions'
require_relative 'rspec/examples'

require_relative 'rspec/proxies/base'
require_relative 'rspec/proxies/action'
require_relative 'rspec/proxies/example'

module Fictium
  module RSpec
    class << self
      def document
        @document ||= Fictium::Document.new
      end
    end
  end
end

RSpec.configure do |config|
  config.extend Fictium::RSpec::ProxyHandler
  config.include Fictium::RSpec::Resources, type: :controller
  config.include Fictium::RSpec::Actions, fictium_action: true
  config.include Fictium::RSpec::Examples, fictium_example: true

  config.after(:suite) do
    Fictium::RSpec.document.export
  end
end
