require_relative 'vending_machine.rb'
require 'tty-prompt'

@product_batches = [
  ProductBatch.new(Product.new("Coca-Cola", 125), 20),
  ProductBatch.new(Product.new("Mars", 75), 10),
  ProductBatch.new(Product.new("Sprite", 350), 5),
  ProductBatch.new(Product.new("Chips", 575), 10),
  ProductBatch.new(Product.new("Crisps", 400), 2)
]

@vm = VendingMachine.new(@product_batches)

@prompt = TTY::Prompt.new

def additional_options(choices)
  choices.choice name: "Cancel transaction", value: "cancel_transaction"
  choices.choice name: "Exit", value: "exit"
end

def product_selector
  @prompt.select("Select the product:") do |menu|
    @vm.products.each do |product_name, product_batch| 
      if product_batch.in_stock?
       menu.choice name: "#{product_name}, Price: #{product_batch.product.humanized_price}, Amount: #{product_batch.amount}",  value: product_name
      else
       menu.choice name: "#{product_name}, Price: #{product_batch.product.humanized_price}, Amount: 0",  value: product_name, disabled: "(out of stock)"
      end
    end
    additional_options(menu)
  end
end

def money_selector
  @prompt.select("Put money:") do |coins|
    money = Money.constants.map { |const_name| [const_name, Money.const_get(const_name)] }.to_h
    money.sort_by { |_, money_item| money_item.cents_amount }.each do |const_name, money_item|
      coins.choice name: "#{const_name} - #{money_item.to_s}", value: "Money::#{const_name}"
    end
    additional_options(coins)
  end
end

def cancel_or_exit(option_name)
  @vm.cancel if option_name == 'cancel_transaction'
  raise TTY::Reader::InputInterrupt if option_name == 'exit'
end

def purchase(product_name)
  if ['cancel_transaction', 'exit'].include?(product_name)
    cancel_or_exit(product_name)
  else
    @vm.purchase(product_name)
  end
end

def pay(money_item_name)
  if ['cancel_transaction', 'exit'].include?(money_item_name)
    cancel_or_exit(money_item_name)
  else
    @vm.pay(Money.const_get(money_item_name))
  end
end

begin
  while true

    product_name = product_selector
    purchase(product_name)
  
    while @vm.current_session_active?
      money_item_name = money_selector
      pay(money_item_name)
    end
    
  end
rescue TTY::Reader::InputInterrupt
  p "Goodbye!"
end