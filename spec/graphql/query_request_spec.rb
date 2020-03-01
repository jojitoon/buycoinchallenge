RSpec.describe Types::QueryType, type: :request do

  describe 'make query calls' do
    it "get a successful sell price" do
      post '/graphql', params: { query: query(type: 'sell', margin: 20, exchangeRate: 200) }

      json = JSON.parse(response.body)
      data = "%.2f" % json['data']['calculatePrice']
      expect(data).to eq(calculate('sell', 20, 200))
    end

    it "get a successful buy price" do
      post '/graphql', params: { query: query(type: 'buy', margin: 20, exchangeRate: 200) }

      json = JSON.parse(response.body)
      data = "%.2f" % json['data']['calculatePrice']
      expect(data).to eq(calculate('buy', 20, 200))
    end

    it "unsuccessful request" do
      post '/graphql', params: { query: query1(type: 'buy', margin: 20) }

      json = JSON.parse(response.body)
      data = json['errors'][0]['message']
      expect(data).to eq("Field 'calculatePrice' is missing required arguments: exchangeRate")
    end

    it "unsuccessful request" do
      post '/graphql', params: { query: query2(type: 'buy', exchangeRate: 20) }

      json = JSON.parse(response.body)
      data = json['errors'][0]['message']
      expect(data).to eq("Field 'calculatePrice' is missing required arguments: margin")
    end

  end

  def query(type:, margin:, exchangeRate:)
    <<~GQL
      query {
         calculatePrice(type: #{type}, margin: #{margin}, exchangeRate: #{exchangeRate})
      }
      GQL
  end

  def query1(type:, margin:)
    <<~GQL
      query {
         calculatePrice(type: #{type}, margin: #{margin})
      }
      GQL
  end

  def query2(type:, exchangeRate:)
    <<~GQL
      query {
         calculatePrice(type: #{type}, exchangeRate: #{exchangeRate})
      }
      GQL
  end
end
