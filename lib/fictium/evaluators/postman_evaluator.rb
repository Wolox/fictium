module Fictium
  class PostmanEvaluator
    attr_reader :subject

    def initialize(subject)
      @subject = subject
    end

    def evaluate(&block)
      instance_eval(&block)
    end

    private

    def event
      # Always allow
    end

    def protocol_profile_behavior
      # Always allow
    end

    def variable
      # Always allow
    end

    def auth
      raise NoMethodError unless resource? || document?
      # TODO: Implement
    end

    def resource?
      subject.is_a?(Fictium::Resource)
    end

    def document?
      subject.is_a?(Fictium::Document)
    end
  end
end
