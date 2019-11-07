module Fictium
  module RSpec
    module ProxyHandler
      def describe(subject, *args, **kwargs, &block)
        return subject.evaluate(block, args, kwargs) if subject.is_a?(Proxies::Base)

        super
      end
    end
  end
end
