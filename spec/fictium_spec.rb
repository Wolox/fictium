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

  describe '.validate_config!' do
    subject(:validation) { described_class.validate_config! }

    let(:configuration) { described_class.configuration }

    context 'when configuration is valid' do
      it 'does not raise an error' do
        expect { validation }.not_to raise_error
      end
    end

    context 'when fixture_path is missing' do
      it 'raises an error' do
        old_config = configuration.fixture_path
        configuration.fixture_path = nil
        expect { validation }.to raise_error(StandardError)
        configuration.fixture_path = old_config
      end
    end
  end
end
