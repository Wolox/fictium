describe Fictium::Example do
  let(:action) { Fictium::Action.new(resource) }
  let(:resource) { Fictium::Resource.new(document) }
  let(:document) { Fictium::Document.new }

  describe '.new' do
    subject(:new_instance) { described_class.new(action) }

    it 'contains  the action as a member' do
      expect(new_instance.action).to eq action
    end
  end

  describe '#default?' do
    subject(:example) { described_class.new(action) }

    it 'responds the same as de default value' do
      expect(example.default?).to be example.default
    end
  end
end
