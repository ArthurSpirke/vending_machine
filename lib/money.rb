require_relative 'money_item.rb'

module Money
  extend self

  QUARTER_COIN = MoneyItem.new(25)
  HALF_COIN = MoneyItem.new(50)
  ONE_DOLLAR = MoneyItem.new(100)
  TWO_DOLLARS = MoneyItem.new(200)
  FIVE_DOLLARS = MoneyItem.new(500)

  def valid?(money_item)
    self.constants.any? { |const_name| self.const_get(const_name).cents_amount == money_item.cents_amount }
  end
  
end