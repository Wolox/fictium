module Fictium
  class Configuration
    VOWEL = /[aeiou]/i.freeze
    private_constant :VOWEL

    attr_accessor :exporters, :summary_format, :default_action_descriptors,
                  :unknown_action_descriptor, :default_subject

    def initialize
      # TODO: Add default exporter in exporter list
      @exporters = []

      @summary_format = method(:default_summary_format)
      @default_action_descriptors = {
        default_summary_for_index: method(:default_summary_for_index),
        default_summary_for_show: method(:default_summary_for_show),
        default_summary_for_update: method(:default_summary_for_update),
        default_summary_for_destroy: method(:default_summary_for_destroy)
      }
      @unknown_action_descriptor = method(:default_unknown_action_descriptor)
      @default_subject = 'This endpoint'
    end

    private

    def default_summary_format(resources)
      "Handles API #{resources}."
    end

    def default_unknown_action_descriptor(action, action_name)
      name = action_name.humanize
      "#{conjugate(name)} an existing #{action.resource.name}."
    end

    def default_summary_for_index(action)
      "#{default_subject} lists all available #{action.resource.name.pluralize}"
    end

    def default_summary_for_show(action)
      name = action.resource.name
      "#{default_subject} shows details of #{get_preposition(name)} #{name}."
    end

    def default_summary_for_update(action)
      name = action.resource.name
      "#{default_subject} updates #{get_preposition(name)} #{name}."
    end

    def default_summary_for_destroy(action)
      name = action.resource.name
      "#{default_subject} destroys #{get_preposition(name)} #{name}."
    end

    def conjugate(name)
      ::Verbs::Conjugator.conjugate name, subject: default_subject, tense: :present, person: :third
    end

    def get_preposition(resource_name)
      resource_name.start_with?(VOWEL) ? 'an' : 'a'
    end
  end
end
