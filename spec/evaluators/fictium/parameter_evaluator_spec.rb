describe Fictium::ParameterEvaluator do
  describe '#evaluate_params' do
    subject(:evaluator) { described_class.new }

    context 'with a valid factory build' do
      before do
        evaluator.evaluate_params do
          a required: false
          b schema: { ref: '/' }
          c allow_empty: false
        end
      end

      it 'returns the parameters as a hash with correct keys' do
        expect(evaluator.params.keys).to match_array %w[a b c]
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
        a
      end
    end

    it 'gets a given parameter by name as a hash' do
      expect(evaluator[:a]).to be_a(Hash)
    end
  end
end
