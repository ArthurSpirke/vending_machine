require 'spec_helper'

RSpec.describe PurchaseSession do
  let(:default_product) { Product.new("Coca-Cola", 150) }
  let(:default_money_item) { MoneyItem.new(100) }
  subject { described_class.new(default_product) }

  describe "#top_up_balance" do
    context "when add a money item" do
      it "adds a money item to the money array" do
        expect { subject.top_up_balance(default_money_item) }.to change { subject.money.size }.from(0).to(1)
      end
    end
  end

  describe "#enough_balance?" do
    context "when total number of money items' amounts greater than product's price" do
      before do
        subject.top_up_balance(default_money_item)
        subject.top_up_balance(MoneyItem.new(50))
      end

      it "returns true" do
        expect(subject.enough_balance?).to eq true
      end
    end

    context "when total number of money items' amounts less than product's price" do
      before do
        subject.top_up_balance(default_money_item)
      end

      it "returns false" do
        expect(subject.enough_balance?).to eq false
      end
    end
  end

  describe "#amount_left_to_purchase" do
    it "returns humanized representation about the amount of money which is left for completing the purchase" do
      expect(subject.amount_left_to_purchase).to eq "1$ 50c"
    end
  end

  describe "#total_balance" do
    it "returns humanized representation about the total balance the purchase" do
      expect(subject.total_balance).to eq "0$ 0c"
    end
  end
end