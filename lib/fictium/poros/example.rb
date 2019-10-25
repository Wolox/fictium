module Fictium
  class Example < Fictium::Model
    attr_reader :action
    attr_accessor :status_code, :response_body, :content_type, :default

    def initialize(action)
      @action = action
    end

    def process_http_response(response)
      self.status_code = response.status
      self.response_body = response.body
      self.content_type = response.content_type
    end

    def default?
      default
    end
  end
end
