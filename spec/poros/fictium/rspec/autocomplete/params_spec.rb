describe Fictium::RSpec::Autocomplete::Params do
  describe '#extract_path' do
    subject(:extract) { described_class.send(:extract_path, action, request) }

    let(:action) { resource.create_action }
    let(:resource) { document.create_resource }
    let(:document) { Fictium::Document.new }
    let(:request) { instance_double(ActionDispatch::TestRequest) }

    before do
      allow(request).to receive(:path_parameters).and_return({})
    end

    context 'when the path cannot be guessed' do
      it 'returns an empty path' do
        extract
        expect(action.path).to eq ''
      end
    end
  end
end
