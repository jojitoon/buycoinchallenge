module Resolvers
  class CalculatePrice
    def self.run(type:, margin:, rate:)
      get_price = get_price()
      price = get_price["bpi"]["USD"]["rate_float"]
      new_price = set_margin(type, margin, price)
      "%.2f" % (rate * new_price)
    end
    def self.set_margin(type,margin, price)
      computed_margin = margin * price / 100

      if(type=="sell")
        price - computed_margin
      else
        price + computed_margin
      end
    end

    def self.request_api(url)
      response = Excon.get(url)
      return nil if response.status != 200
      puts JSON.parse(response.body)
      JSON.parse(response.body)
    end

    def self.get_price()
      request_api("https://api.coindesk.com/v1/bpi/currentprice.json")
    end
  end

end
