class ChangeCalculator

  def initialize(money_items, product_price)
    @money_items = money_items
    @product_price = product_price
  end

  def money_items_for_change
    return [] if money_items.empty? || amount_for_change.zero?
    calculated_amount = amount_for_change
    collected_change = []
    
    while calculated_amount > 0
      available_money_items.each do |money_item|
        if calculated_amount >= money_item.cents_amount
          collected_change << money_item
          calculated_amount = calculated_amount - money_item.cents_amount
          break
        end
      end
    end

    collected_change
  end

  private

  attr_reader :money_items, :product_price

  def amount_for_change
    @amount_for_change ||= money_items.sum(&:cents_amount) - product_price
  end

  def available_money_items
    @available_money_items ||= Money.constants.map { |const_name| Money.const_get(const_name) }.sort_by { |_| -_.cents_amount }
  end

end