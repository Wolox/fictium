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
        allow_empty: allow_empty,
        schema: format_schema(kwargs)
      }
    end

    def format_schema(args)
      return unless args[:schema].present?

      schema_evaluator.format(ref: args[:schema][:ref]) if args[:schema][:ref].present?
      schema_evaluator.format(args[:schema])
    end

    def schema_evaluator
      @schema_evaluator ||= Fictium::SchemaEvaluator.new
    end
  end
end
