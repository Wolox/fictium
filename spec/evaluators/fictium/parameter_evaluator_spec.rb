describe Fictium::ParameterEvaluator do
  describe '#evaluate_params' do
    subject(:evaluator) { described_class.new }

    let(:valid_params) do
      ActiveSupport::HashWithIndifferentAccess.new(a: 2, b: 3, c: 4)
    end

    context 'with a valid factory build' do
      before do
        evaluator.evaluate_params do
          a { 2 }
          b { 3 }
          c { 4 }
        end
      end

      it 'evaluates parameters in a factory style' do
        expect(evaluator.params).to eq valid_params
      end
    end

    context 'when using an argument at the block' do
      it 'passes the evaluator as the parameter' do
        evaluator.evaluate_params do |ev|
          expect(evaluator).to be ev
        end
      end
    end
  end

  describe '#[]' do
    subject(:evaluator) { described_class.new }

    before do
      evaluator.evaluate_params do
        a { 2 }
      end
    end

    it 'gets a given parameter by name' do
      expect(evaluator[:a]).to eq(2)
    end
  end

  describe '#respond_to?' do
    subject(:evaluator) { described_class.new }

    let(:method) { Faker::Name.name }

    context 'when a block is given' do
      it 'does not raise an error' do
        expect { evaluator.send(method) {} }.not_to raise_error
      end
    end

    context 'when no block is given' do
      it 'raises a NoMethodError' do
        expect { evaluator.send(method) }.to raise_error(NoMethodError)
      end
    end
  end
end
