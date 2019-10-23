describe Fictium::Resource do
  subject(:resource) { described_class.new(document) }

  let(:document) { Fictium::Document.new }

  describe '#create_action' do
    it 'returns a new instance of Fictium::Action' do
      expect(resource.create_action).to be_an_instance_of(Fictium::Action)
    end

    it 'adds a new action to the list' do
      expect { resource.create_action }.to change(resource.actions, :size).by(1)
    end
  end
end
