module InfoScreen
  extend self

  def show_help_info
    p "How does this machine work?"
    p "Use @vm.purchase('Coca-Cola') to start purchasing the Coca-Cola product"
    p "Use @vm.pay(Money::QUARTER_COIN) to put 25 cents for the Coca-Cola product"
    p "Use @vm.cancel if you want to cancel the transaction and be refunded with your money"
    p "Use @vm.add_product_batch(ProductBatch.new(Product.new('Coca-Cola', 150), 5)) to add more Coca-Cola items"
    p "Use @vm.show_state to show the state of the current session"
    p "Use @vm.show_machine_state to show the state of the machine and products in it"
    p "Use @vm.show_help to print this information again"
    p "Allowed coins and banknotes:"
    Money.constants.each do |money_item_constant|
      money_item = Money.const_get(money_item_constant)
      p "Money::#{money_item_constant} - #{money_item.to_s}"
    end
    separator
  end

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

  def show_the_machine_state(vending_machine)
    number_of_products = vending_machine.products.size
    p "The machine has #{number_of_products} products"
    
    if number_of_products > 0
      p "List of the products: "
      vending_machine.products.each do |product_name, product_batch|
        product = product_batch.product
        amount = product_batch.amount
        p "Name - #{product_name}, price - #{product.humanized_price}, amount - #{amount}"
      end
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
    p "Please take the change - #{money_items.map(&:to_s).join(", ")}"
    separator
  end

  def show_returned_money(money_items)
    p "Please take your refunded money - #{money_items.map(&:to_s).join(", ")}"
    separator
  end

  def separator
    p "--------------------------"
  end

end