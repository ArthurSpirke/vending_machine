class ProductBatch

  attr_reader :product, :amount

  def initialize(product, amount = 0)
    @product = product
    @amount = amount
  end

  def add(additional_amount)
    raise "added amount should be greater than 0" if additional_amount.nil? || additional_amount < 0
    @amount += additional_amount
  end

  def remove_one_item
    raise "the batch of #{product.name} is already empty" if amount == 0
    @amount = amount - 1
  end

end