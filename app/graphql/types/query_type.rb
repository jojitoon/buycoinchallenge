module Types
  class QueryType < Types::BaseObject

    field :calculate_price, Float, null: false, description: "Endpoint to calculate price"  do
      argument :type, Types::TypeEnum, required: true
      argument :margin, Float, required: true
      argument :exchange_rate, Float, required: true, as: :rate
    end

    def calculate_price(type:, margin:, rate:)
      get_price = get_price()
      price = get_price["bpi"]["USD"]['rate_float']
      new_price = set_margin(type, margin, price)
      "%.2f" % (rate * new_price)
    end

    private
    def set_margin(type,margin, price)
      computed_margin = margin * price / 100

      if(type=="sell")
        price - computed_margin
       else
        price + computed_margin
       end
    end

    def request_api(url)
      response = Excon.get(url)
      return nil if response.status != 200
      JSON.parse(response.body)
    end

    def get_price()
      request_api("https://api.coindesk.com/v1/bpi/currentprice.json")
    end

  end

end
