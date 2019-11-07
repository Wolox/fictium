describe Fictium::Action do
  subject(:action) { described_class.new(resource) }

  let(:resource) { Fictium::Resource.new(document) }
  let(:document) { Fictium::Document.new }

  describe '#full_path' do
    before do
      resource.base_path = '/api/v1'
      action.path = '/test'
    end

    it 'returns a full path equal to the resource and its path' do
      expect(action.full_path).to eq("#{resource.base_path}#{action.path}")
    end
  end

  describe '#add_params_in' do
    before do
      action.add_params_in(:head) do
        a
      end
    end

    it 'adds parameters in a section' do
      expect(action[:head]).to be_present
    end

    it 'adds the new parameters properly' do
      expect(action[:head][:a]).to be_a(Hash)
    end
  end

  describe '#add_example' do
    it 'creates a new instance of Fictium::Example' do
      expect(action.add_example).to be_an_instance_of(Fictium::Example)
    end

    it 'adds a new example to the list' do
      expect { action.add_example }.to change(action.examples, :size).by(1)
    end
  end
end
