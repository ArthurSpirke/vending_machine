require_relative 'money_to_string.rb'

class Product

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def humanized_price
    MoneyToString.humanized_from_cents(price)
  end

end