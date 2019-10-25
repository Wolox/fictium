module Fictium
  module RSpec
    module Proxies
      class Example < Base
        def additional_arguments
          { fictium_example: true }
        end

        def evaluate_method_name
          :context
        end
      end
    end
  end
end
