module Types
  class TypeEnum < Types::BaseEnum
    value "buy", "API would add the computed value of the margin percentage to the current Bitcoin price it just retrieved"
    value "sell", "API would subtract the computed value of the margin percentage from the current Bitcoin price it just retrieved"
  end
end
