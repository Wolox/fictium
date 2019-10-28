module Fictium
  class Example < Fictium::Model
    attr_reader :action
    attr_accessor :summary, :description, :response, :request, :default, :headers

    def initialize(action)
      @action = action
      @headers = ActiveSupport::HashWithIndifferentAccess.new
    end

    def default?
      default
    end
  end
end
