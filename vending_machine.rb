Dir["./lib/*.rb"].each {|file| require file }

class VendingMachine

  def initialize(product_batches = [])
    @product_batches = product_batches
    @current_session = nil
  end

  def purchase(product_name)
    return InfoScreen.current_session_still_active(current_session) if current_session
    return InfoScreen.no_product_exists(product_name) unless products.include?(product_name)

    product_batch = products[product_name]
    return InfoScreen.product_has_ended(product_batch) if product_batch.amount.zero?

    initialize_new_purchase_session(product_batch.product)
    InfoScreen.show_session_state(current_session)
  end

  def pay(money_item)
    return InfoScreen.no_current_session unless current_session

    current_session.top_up_balance(money_item)
    if current_session.enough_balance?
      current_session.close_purchase_and_return_change
      products[current_session.product.name].remove_one_item
      cancel_current_session
    else
      InfoScreen.not_enough_funds_for_purchase(current_session)
    end
  end

  def cancel
    return InfoScreen.no_current_session unless current_session
    current_session.cancel_purchase_and_refund_money
    cancel_current_session
  end

  def add_product_batch(product_batch)
    new_product_name = product_batch.product.name

    if products.include?(new_product_name)
      products[new_product_name].add(product_batch.amount)
    else
      products[new_product_name] = product_batch
    end
  end

  def products
    @products ||= begin
      product_batches.map do |product_batch|
        [product_batch.product.name, product_batch]
      end.to_h
    end
  end

  def current_session_active?
    !current_session.nil?
  end

  private

  attr_reader :product_batches, :current_session

  def initialize_new_purchase_session(product)
    @current_session = PurchaseSession.new(product)
  end

  def cancel_current_session
    @current_session = nil
  end
end

