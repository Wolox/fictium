module Fictium
  class Example < Fictium::Model
    attr_reader :action
    attr_accessor :summary, :description, :response, :request, :default

    def initialize(action)
      @action = action
    end

    def process_http_response(response)
      self.response = self.response || {
        status: response.status,
        body: response.body,
        content_type: response.content_type
      }
      process_http_request(response.request)
    end

    def default?
      default
    end

    private

    def process_http_request(request)
      self.request ||= {}
      self.request.merge!(
        content_type: request.content_type,
        body: request.body.string
      )
      action.method = request.method.downcase.to_sym if action.method.blank?
    end
  end
end
