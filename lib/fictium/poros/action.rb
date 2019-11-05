module Fictium
  class Action < Fictium::Model
    attr_reader :resource, :examples
    attr_accessor :path, :summary, :description, :method

    def initialize(resource)
      @resource = resource
      @params = ActiveSupport::HashWithIndifferentAccess.new
      @examples = []
    end

    def full_path
      "#{resource.base_path}#{path}"
    end

    def [](section)
      @params[section] ||= ActiveSupport::HashWithIndifferentAccess.new
    end

    def add_params_in(section, &block)
      self[section].merge!(Fictium::ParameterEvaluator.new.evaluate_params(&block))
      nil
    end

    def add_example
      Fictium::Example.new(self).tap { |example| examples << example }
    end
  end
end
