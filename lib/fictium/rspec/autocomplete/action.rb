module Fictium
  module RSpec
    module Autocomplete
      module Action
        ACTION_NAME = /#([A-Z_]+)/i.freeze
        DEFAULT_PATHS = {
          index: '',
          create: '',
          new: '/new',
          show: '/{id}',
          update: '/{id}',
          destroy: '/{id}'
        }.freeze
        class << self
          def description_attributes(action, description)
            name = find_action_name(description)&.downcase
            find_summary(action, name)
            find_path(action, name)
          end

          private

          def find_summary(action, name)
            return if name.blank?

            key = :"default_summary_for_#{name}"
            summary_method = descriptors[key] || Fictium.configuration.unknown_action_descriptor
            one_argument = summary_method.arity == 1
            action.summary =
              one_argument ? summary_method.call(action) : summary_method.call(action, name)
          end

          def descriptors
            @descriptors ||= Fictium.configuration.default_action_descriptors || {}
          end

          def find_path(action, name)
            return if name.blank?

            key = name.to_sym
            action.path = DEFAULT_PATHS[key] || "/{id}/#{name}"
          end

          def find_action_name(description)
            match = description.match(ACTION_NAME)
            match.presence && match[1]
          end
        end
      end
    end
  end
end
