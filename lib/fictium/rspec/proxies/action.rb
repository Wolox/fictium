module Fictium
  module RSpec
    module Proxies
      class Action < Base
        def additional_arguments
          { fictium_action: true }
        end
      end
    end
  end
end
