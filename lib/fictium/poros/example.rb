module Fictium
  class Example < Fictium::Model
    attr_reader :action
    attr_accessor :status_code, :response_body, :content_type

    def initialize(action)
      @action = action
    end
  end
end
