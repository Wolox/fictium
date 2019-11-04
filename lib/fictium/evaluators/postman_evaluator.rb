module Fictium
  class PostmanEvaluator
    attr_reader :subject

    delegate :postman, to: :subject

    def initialize(subject)
      @subject = subject
    end

    def evaluate(&block)
      instance_eval(&block)
    end

    private

    def pre_request(script:, disabled: false)
      postman.event ||= []
      postman.event << {
        listen: :pre_request,
        disabled: disabled,
        script: {
          exec: script.to_s.lines
        }
      }
    end

    def test(script:, disabled: false)
      postman.event ||= []
      postman.event << {
        listen: :test,
        disabled: disabled,
        script: {
          exec: script.to_s.lines
        }
      }
    end

    def variable(name:, value: '', type: :string, disabled: false)
      postman.variable ||= []
      postman.variable << { name: name, value: value, type: type, disabled: disabled }
    end

    def auth(**kwargs)
      raise NoMethodError unless resource? || document?

      key = kwargs.keys.first
      postman.auth = { type: key, key => kwargs[key] }
    end

    def resource?
      subject.is_a?(Fictium::Resource)
    end

    def document?
      subject.is_a?(Fictium::Document)
    end
  end
end
