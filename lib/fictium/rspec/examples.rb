module Fictium
  module RSpec
    module Examples
      extend ActiveSupport::Concern

      included do
        metadata[:fictium_example] = metadata[:fictium_action].add_example
        metadata[:fictium_example].summary = metadata[:description]

        context 'with documentation' do
          let(:metadata) { self.class.metadata }

          it 'documents the example' do
            expect(metadata[:fictium_example]).to be_present
            metadata[:fictium_example].process_http_response(response)
          end
        end
      end

      class_methods do
        def default_example
          metadata[:fictium_example].default = true
        end

        def request_schema(obj = nil, ref: nil)
          error_msg = 'request_schema needs a JSON-like object or a reference'
          raise ArgumentError, error_msg if obj.blank? && ref.blank?

          metadata[:fictium_example].request ||= {}
          metadata[:fictium_example].request[:schema] = ref || obj
        end

        def response_schema(obj = nil, ref: nil)
          error_msg = 'response_schema needs a JSON-like object or a reference'
          raise ArgumentError, error_msg if obj.blank? && ref.blank?

          metadata[:fictium_example].response ||= {}
          metadata[:fictium_example].response[:schema] = ref || obj
        end

        def require_request_body!
          metadata[:fictium_example].request ||= {}
          metadata[:fictium_example].request[:required] = true
        end
      end
    end
  end
end
