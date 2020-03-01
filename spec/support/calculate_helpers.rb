module CalculateHelpers
  def calculate(type,margin, rate)
    computed_margin = margin * 20 / 100
    new_price = 0
    if(type=="sell")
      new_price = 20 - computed_margin
    else
      new_price = 20 + computed_margin
    end
    "%.2f" % (new_price * rate)
  end
end
