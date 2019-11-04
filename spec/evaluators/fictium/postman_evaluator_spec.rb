describe Fictium::PostmanEvaluator do
  subject(:evaluator) { described_class.new(target) }

  let(:target) { Fictium::Document.new }

  describe '#evaluate' do
    before do
      evaluator.evaluate do
        pre_request script: 'console.log("A");'
        test script: 'console.log("TEST");'
        variable name: 'x'
        auth apikey: { key: 'token' }
      end
    end

    it 'evaluates postman properties' do
    end
  end
end
