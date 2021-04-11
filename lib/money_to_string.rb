module MoneyToString
  extend self

  def humanized_from_cents(cents)
    dollars_calculated = cents / 100
    cents_calculated = cents - (dollars_calculated * 100)
    "#{dollars_calculated}$ #{cents_calculated}c"
  end
end