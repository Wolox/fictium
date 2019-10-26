module Fictium
  class Resource < Fictium::Model
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
  end
end
