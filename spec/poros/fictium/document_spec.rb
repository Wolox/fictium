describe Fictium::Document do
  describe '#create_resource' do
    subject(:document) { described_class.new }

    it 'returns a new instance of Fictium::Resource' do
      expect(document.create_resource).to be_an_instance_of(Fictium::Resource)
    end

    it 'adds a new resource to the resource list' do
      expect { document.create_resource }.to change(document.resources, :size).by(1)
    end
  end
end
