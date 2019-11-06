module Fictium
  class SchemaEvaluator
    def format(obj)
      obj[:ref].present? ? { '$ref': obj[:ref] } : obj
    end
  end
end
