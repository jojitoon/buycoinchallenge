module Types
  class QueryType < Types::BaseObject

    field :calculate_price, Float, null: false, description: "Endpoint to calculate price"  do
      argument :type, Types::TypeEnum,'Provide type. Must be either buy or sell', required: true
      argument :margin, Float,'Must provide the percentage margin for buying and selling', required: true
      argument :exchange_rate, Float,'Must provide Naira/Dllar exchange rate', required: true, as: :rate
    end

    def calculate_price(type:, margin:, rate:)
      Resolvers::CalculatePrice.run(type: type, margin: margin, rate: rate)
    end
  end
end
