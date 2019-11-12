module Fictium
  class Configuration
    VOWEL = /[aeiou]/i.freeze
    DEFAULT_IGNORED_HEADERS_GROUPS = %w[rack. action_dispatch. action_controller.].freeze
    DEFAULT_IGNORED_HEADERS = %w[
      accept content-type authorization http_accept content_type
      request_method server_name server_port query_string
      http_cookie path_info x-frame-options x-xss-protection x-content-type-options
      x-download-options x-permitted-cross-domain-policies referrer-policy
      https script_name http_host remote_addr http_user_agent
      http_authorization content_length raw_post_data referrer-policy
    ].freeze
    private_constant :VOWEL

    attr_reader :info, :api_blueprint
    attr_accessor :exporters, :summary_format, :default_action_descriptors,
                  :unknown_action_descriptor, :default_subject, :fixture_path,
                  :export_path, :default_response_content_type, :pretty_print,
                  :ignored_header_values, :ignored_header_groups, :default_person

    def initialize
      @info = Fictium::Configuration::Info.new
      @api_blueprint = Fictium::Configuration::ApiBlueprint.new
      @exporters = [Fictium::OpenApi::V3Exporter.new]

      @summary_format = method(:default_summary_format)
      @pretty_print = true
      setup_descriptors
      setup_strings
      @ignored_header_values = DEFAULT_IGNORED_HEADERS.dup
      @ignored_header_groups = DEFAULT_IGNORED_HEADERS_GROUPS.dup
    end

    private

    def setup_descriptors
      @default_action_descriptors = {
        default_summary_for_index: method(:default_summary_for_index),
        default_summary_for_show: method(:default_summary_for_show),
        default_summary_for_create: method(:default_summary_for_create),
        default_summary_for_update: method(:default_summary_for_update),
        default_summary_for_destroy: method(:default_summary_for_destroy)
      }
      @unknown_action_descriptor = method(:default_unknown_action_descriptor)
    end

    def setup_strings
      @default_subject = nil
      @export_path = 'doc'
      @default_response_content_type = 'text/plain'
      @default_person = :second
    end

    def default_summary_format(resources)
      "Handles API #{resources}."
    end

    def default_unknown_action_descriptor(action, action_name)
      name = action_name.humanize
      "#{conjugate(name)} #{get_preposition(name)} #{action.resource.name}."
    end

    def default_summary_for_index(action)
      "List all available #{action.resource.name.pluralize}"
    end

    def default_summary_for_show(action)
      name = action.resource.name
      "Show details of #{get_preposition(name)} #{name}."
    end

    def default_summary_for_create(action)
      name = action.resource.name
      "Create a new #{name}."
    end

    def default_summary_for_update(action)
      name = action.resource.name
      "Update #{get_preposition(name)} #{name}."
    end

    def default_summary_for_destroy(action)
      name = action.resource.name
      "Destroy #{get_preposition(name)} #{name}."
    end

    def conjugate(name)
      ::Verbs::Conjugator.conjugate name, subject: default_subject,
                                          tense: :present,
                                          person: default_person
    end

    def get_preposition(resource_name)
      resource_name.start_with?(VOWEL) ? 'an' : 'a'
    end
  end
end
