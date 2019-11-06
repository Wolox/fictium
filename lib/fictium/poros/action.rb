module Fictium
  class Action < Fictium::Model
    ACTION_NAME = /#([A-Z_]+)/i.freeze
    PATH_METHODS = /$(get|post|put|patch|delete)/i.freeze
    DEFAULT_PATHS = {
      create: '',
      new: '/new',
      show: '/{id}',
      update: '/{id}',
      destroy: '/{id}'
    }.freeze

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

    def description_attributes(description)
      name = find_action_name(description)&.downcase
      find_summary(name)
      find_path(name)
      find_method(description)
    end

    private

    def find_summary(name)
      return if name.blank?

      key = :"default_summary_for_#{name}"
      summary_method = descriptors[key] || Fictium.configuration.unknown_action_descriptor
      one_argument = summary_method.arity == 1
      self.summary = one_argument ? summary_method.call(self) : summary_method.call(self, name)
    end

    def descriptors
      @descriptors ||= Fictium.configuration.default_action_descriptors || {}
    end

    def find_method(description)
      match = description.match(PATH_METHODS)
      self.method = match.presence && match[1]&.downcase
    end

    def find_path(name)
      return if name.blank?

      key = name.to_sym
      self.path = DEFAULT_PATHS[key].presence || "/{id}/#{name}"
    end

    def find_action_name(description)
      match = description.match(ACTION_NAME)
      match.presence && match[1]
    end
  end
end
