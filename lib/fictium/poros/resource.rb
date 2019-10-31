module Fictium
  class Resource < Fictium::Model
    CONTROLLER_TERMINATION = /Controller$/.freeze

    attr_reader :document, :actions
    attr_accessor :name, :base_path, :summary, :description, :tags

    def initialize(document)
      @document = document
      @actions = []
      @tags = []
    end

    def create_action
      Fictium::Action.new(self).tap { |action| actions << action }
    end

    def name_attributes(controller_name)
      resource_path = controller_name.sub(CONTROLLER_TERMINATION, '').underscore
      self.base_path = "/#{resource_path}"
      path_sections = resource_path.split('/')
      plural = path_sections.last
      self.name = plural.singularize.humanize(capitalize: false)
      self.summary = Fictium.configuration.summary_format.call(plural)
    end
  end
end
