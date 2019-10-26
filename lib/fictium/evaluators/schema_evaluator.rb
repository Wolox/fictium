module Fictium
  class SchemaEvaluator
    def format(obj = nil, ref: nil)
      raise error_message if obj.blank? && ref.blank?

      ref.present? ? { '$ref': ref } : obj
    end

    private

    def error_message
      'Object schemeas needs a hash or a reference path'
    end
  end
end
