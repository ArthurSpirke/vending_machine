class MoneyItem

  attr_reader :cents_amount

  def initialize(cents_amount)
    @cents_amount = cents_amount
    validate!
  end

  def to_s
    return "#{cents_amount / 100}$" if cents_amount % 100 == 0
    return "#{cents_amount}c" if cents_amount % 25 == 0
  end

  private

  def validate!
    raise "cannot be nil" if cents_amount.nil?
    raise "should be greater than 0" if cents_amount <= 0
    raise "should be divisible by 25" unless cents_amount % 25 == 0
    raise "should be either cents or dollars" if cents_amount >= 100 && cents_amount % 100 > 0
  end

end