require_relative 'vending_machine.rb'

@product_batches = [
  ProductBatch.new(Product.new("Coca-Cola", 125), 20),
  ProductBatch.new(Product.new("Mars", 75), 10),
  ProductBatch.new(Product.new("Sprite", 350), 5),
  ProductBatch.new(Product.new("Chips", 575), 10),
  ProductBatch.new(Product.new("Crisps", 400), 2)
]

@vm = VendingMachine.new(@product_batches)