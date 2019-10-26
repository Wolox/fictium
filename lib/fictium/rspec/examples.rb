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
            Fictium::RSpec::Autocomplete::Example.process_http_response(
              metadata[:fictium_example],
              response
            )
          end
        end
      end

      class_methods do
        def default_example
          metadata[:fictium_example].default = true
          metadata[:fictium_schema] = Fictium::SchemaEvaluator.new
        end

        def request_schema(obj = nil, ref: nil)
          metadata[:fictium_example].request ||= {}
          metadata[:fictium_example].request[:schema] =
            metadata[:fictium_schema].format(obj, ref: ref)
        end

        def response_schema(obj = nil, ref: nil)
          metadata[:fictium_example].response[:schema] =
            metadata[:fictium_schema].format(obj, ref: ref)
        end

        def require_request_body!
          metadata[:fictium_example].request ||= {}
          metadata[:fictium_example].request[:required] = true
        end
      end
    end
  end
end
