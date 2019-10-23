module Fictium
  class Document < Fictium::Model
    attr_reader :resources

    def initialize
      @resources = []
    end

    def create_resource
      Fictium::Resource.new(self).tap { |resource| resources << resource }
    end
  end
end
