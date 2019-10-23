module Fictium
  class Configuration
    attr_accessor :exporters

    def initialize
      # TODO: Add default exporter in exporter list
      @exporters = []
    end
  end
end
