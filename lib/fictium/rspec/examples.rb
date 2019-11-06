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
      end
    end
  end
end
