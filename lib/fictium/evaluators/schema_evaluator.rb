module Fictium
  class SchemaEvaluator
    def format(obj = nil)
      raise error_message if obj.blank?

      obj[:ref].present? ? { '$ref': obj[:ref] } : obj
    end

    private

    def error_message
      'Object schemeas needs a hash or a reference path'
    end
  end
end
