module Fictium
  class Action < Fictium::Model
    attr_reader :resource, :examples, :params
    attr_accessor :path, :summary, :description, :method, :tags, :deprecated, :docs

    def initialize(resource)
      @resource = resource
      @params = ActiveSupport::HashWithIndifferentAccess.new
      @examples = []
      @tags = []
      @deprecated = false
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

    def combined_tags
      resource.tags + tags
    end

    def deprecated?
      deprecated
    end

    def default_example
      examples.find(&:default?).presence || examples.first
    end
  end
end
