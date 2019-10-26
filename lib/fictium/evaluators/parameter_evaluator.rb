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

    def method_missing(name, *_, **kwargs) # rubocop:disable Style/MethodMissingSuper
      self[name] = validate_keys(**kwargs) if respond_to_missing?(name)
    end

    def [](name)
      @params[name]
    end

    def []=(name, value)
      @params[name] = value
    end

    private

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end

    def validate_keys(required: false, deprecated: false, allow_empty: false, **kwargs)
      {
        description: kwargs[:description],
        required: required,
        deprecated: deprecated,
        allowEmptyValue: allow_empty,
        schema: kwargs[:schema] && schema_evaluator.format(**kwargs[:schema])
      }
    end

    def schema_evaluator
      @schema_evaluator ||= Fictium::SchemaEvaluator.new
    end
  end
end
