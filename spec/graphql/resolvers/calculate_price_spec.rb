RSpec.describe Resolvers::CalculatePrice do

  let(:result) { described_class.run(args)}

  context 'successful sells result' do
    let(:args) {{ type: 'sell', margin: 20, rate: 200}}

    it "returns the expected result for sells" do
      expect(result).to eq(calculate('sell', 20, 200))
    end
  end

  context 'successful buys result' do
    let(:args) {{ type: 'buy', margin: 20, rate: 200}}

    it "returns the expected result for buys" do
      expect(result).to eq(calculate('buy', 20, 200))
    end
  end
end
