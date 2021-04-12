module InfoScreen
  extend self

  def no_current_session
    p "There is no active current session. Please, use `purchase` for starting one."
    separator
  end

  def current_session_still_active(purchase_session)
    p "Session for purchasing #{purchase_session.product.name} is active. Do you want to cancel it?"
    separator
  end

  def no_product_exists(product_name)
    p "The vending machine does not have product with the name '#{product_name}'"
    separator
  end

  def product_has_ended(product_batch)
    p "The product with the name '#{product_batch.product.name}' is out of stock"
    separator
  end

  def show_session_state(purchase_session)
    if purchase_session
      p "You are buying #{purchase_session.product.name} for #{purchase_session.product.humanized_price}"
      p "Funds already put in the machine: #{purchase_session.total_balance}"
      p "Please, put remaining funds: #{purchase_session.amount_left_to_purchase}"
    else
      p "No purchasing session"
    end
    separator
  end

  def not_enough_funds_for_purchase(purchase_session)
    p "Not enough funds to purchase the '#{purchase_session.product.name}' product"
    p "Please, put additional #{purchase_session.amount_left_to_purchase} into the machine"
    separator
  end

  def show_purchased_product(product)
    p "Congratulations! You can take your '#{product.name}'" 
    separator
  end

  def show_returned_change(money_items)
    if money_items.empty?
      p "Please take the change - 0$ 0c"
    else
      p "Please take the change - #{money_items.map(&:to_s).join(", ")}"
    end
    separator
  end

  def show_returned_money(money_items)
    if money_items.empty?
      p "Please take your refunded money - 0$ 0c"
    else
      p "Please take your refunded money - #{money_items.map(&:to_s).join(", ")}"
    end
    separator
  end

  def separator
    p "--------------------------"
  end

end