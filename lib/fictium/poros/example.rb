module Fictium
  class Example < Fictium::Model
    attr_reader :action
    attr_accessor :summary, :description, :response, :request, :default

    def initialize(action)
      @action = action
    end

    def default?
      default
    end
  end
end
