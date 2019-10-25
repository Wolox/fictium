module Fictium
  module OpenApi
    class V3Exporter
      class PathGenerator
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def generate
          {}
        end
      end
    end
  end
end
