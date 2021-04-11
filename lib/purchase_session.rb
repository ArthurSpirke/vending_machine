require_relative 'money_to_string.rb'

class PurchaseSession

  attr_reader :product, :money

  def initialize(product)
    @product = product
    @money = []
  end

  def top_up_balance(money_item)
    return InfoScreen.invalid_money_item_used(money_item) unless Money.valid?(money_item)
    @money << money_item
  end

  def enough_balance?
    total_balance_in_cents >= product.price
  end

  def close_purchase_and_return_change
    InfoScreen.show_purchased_product(product)
    InfoScreen.show_returned_change(ChangeCalculator.new(money, product.price).money_items_for_change)
  end

  def cancel_purchase_and_refund_money
    InfoScreen.show_returned_money(money)
  end

  def amount_left_to_purchase
    amount_left = product.price - total_balance_in_cents
    MoneyToString.humanized_from_cents(amount_left)
  end

  def total_balance
    MoneyToString.humanized_from_cents(total_balance_in_cents)
  end

  private

  def total_balance_in_cents
    @money.sum(&:cents_amount)
  end

end