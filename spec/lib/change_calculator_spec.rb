require 'spec_helper'

RSpec.describe ChangeCalculator do
  let(:money_items) { [] }
  let(:product_price) { 175 }
  subject { ChangeCalculator.new(money_items, product_price) }

  describe "#money_items_for_change" do
    context "when there are no money items" do
      it "returns an empty array" do
        expect(subject.money_items_for_change).to eq []
      end
    end

    context "when money and product's price are equal" do
      let(:money_items) { [Money::ONE_DOLLAR, Money::HALF_COIN, Money::QUARTER_COIN] }

      it "returns an empty array" do
        expect(subject.money_items_for_change).to eq []
      end
    end

    context "when some change is expected" do
      let(:money_items) { [Money::ONE_DOLLAR, Money::HALF_COIN, Money::ONE_DOLLAR] }

      it "return the change" do
        expect(subject.money_items_for_change).to eq [Money::HALF_COIN, Money::QUARTER_COIN]
      end
    end
  end 
end