describe Fictium::Example do
  describe '.new' do
    subject(:new_instance) { described_class.new(action) }

    let(:action) { Fictium::Action.new(resource) }
    let(:resource) { Fictium::Resource.new(document) }
    let(:document) { Fictium::Document.new }

    it 'contains  the action as a member' do
      expect(new_instance.action).to eq action
    end
  end
end
