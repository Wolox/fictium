module Fictium
  module OpenApi
    class V3Exporter
      class ParamFormatter
        def initialize(ignore_name: false, ignore_in: false)
          @ignore_name = ignore_name
          @ignore_in = ignore_in
        end

        def format(name, section, hash)
          param = (hash || {})
          description = param.slice(:description, :required, :deprecated, :schema)
          description[:description] ||= ''
          description[:name] = name unless ignore_name?
          description[:in] = section unless ignore_in?
          description[:allowEmptyValue] = param[:allow_empty] if param[:allow_empty].present?
          description[:required] = true if section.to_s == 'path'
          add_required_fields(description)
          description
        end

        private

        def ignore_in?
          @ignore_in
        end

        def ignore_name?
          @ignore_name
        end

        def add_required_fields(description)
          return if description[:schema] || description[:content]

          description[:schema] = {}
        end
      end
    end
  end
end
