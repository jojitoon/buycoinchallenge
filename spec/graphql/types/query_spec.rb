RSpec.describe Types::QueryType do
  types = GraphQL::Define::TypeDefiner.instance
  describe 'testing caculateprice' do
    query_result = new described_class.fields['calculatePrice']

    it "has a calulate price query field that return Float" do
      expect(described_class).to have_field(:calculate_price).that_returns(!types.Float)
    end
  end
end
