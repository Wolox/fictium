describe Fictium do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'yields a configuration' do
      described_class.configure do |config|
        expect(config).to be_an_instance_of(described_class::Configuration)
      end
    end
  end
end
