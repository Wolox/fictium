module Fictium
  class ParameterEvaluator
    attr_reader :params

    def initialize
      @params = ActiveSupport::HashWithIndifferentAccess.new
    end

    def evaluate_params(&block)
      if block.arity == 1
        block.call(self)
      else
        instance_eval(&block)
      end
      @params
    end

    def method_missing(name, *args)
      return self[name] = yield if respond_to_missing?(name) && block_given?

      super
    end

    def [](name)
      @params[name]
    end

    def []=(name, value)
      @params[name] = value
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end
  end
end
