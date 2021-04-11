require 'spec_helper'

RSpec.describe VendingMachine do
  let(:default_product_1) { Product.new("Coca-Cola", 150) }
  let(:default_product_2) { Product.new("Mars", 225) }
  let(:default_product_3) { Product.new("Nuts", 175) }
  let(:default_product_batch_1) { ProductBatch.new(default_product_1, 10) }
  let(:default_product_batch_2) { ProductBatch.new(default_product_2, 5) }
  let(:default_product_batch_3) { ProductBatch.new(default_product_3, 0) }
  let(:default_product_batches) { [default_product_batch_1, default_product_batch_2, default_product_batch_3] }
  subject { described_class.new(default_product_batches) }


  describe "#purchase" do
    context "when current session is active" do
      before do
        subject.purchase("Mars")
      end

      it "returns related info" do
        expect(InfoScreen).to receive(:current_session_still_active)
        subject.purchase("Coca-Cola")
      end
    end

    context "when there is no product found in the list" do
      it "returns related info" do
        expect(InfoScreen).to receive(:no_product_exists)
        subject.purchase("Apple")
      end
    end

    context "when the product is out of stock" do
      it "returns related info" do
        expect(InfoScreen).to receive(:product_has_ended)
        subject.purchase("Nuts")
      end
    end

    context "when new purchase session is initialized" do
      it "returns related info" do
        expect(InfoScreen).to receive(:show_session_state)
        subject.purchase("Coca-Cola")
      end
    end
  end

  describe "#pay" do
    let(:money_item) { MoneyItem.new(100) }

    context "when no active session is presented" do
      it "returns related info" do
        expect(InfoScreen).to receive(:no_current_session)
        subject.pay(money_item)
      end
    end

    context "when session exists and not enough balance" do
      before do
        subject.purchase("Coca-Cola")
      end

      it "returns related info" do
        expect(InfoScreen).to receive(:not_enough_funds_for_purchase)
        subject.pay(money_item)
      end
    end

    context "when session exists and enough balance" do
      before do
        subject.purchase("Coca-Cola")
        subject.pay(money_item)
      end

      it "removes one item from the product batch" do 
        expect { subject.pay(MoneyItem.new(50)) }.to change { subject.products["Coca-Cola"].amount }.from(10).to(9)
      end

      it "removes the session" do
        expect(subject).to receive(:cancel_current_session)
        subject.pay(MoneyItem.new(50))
      end
    end
  end

  describe "#cancel" do
    context "when current session exists" do
      before do
        subject.purchase("Coca-Cola")
      end

      it "cancels the session" do
        expect(subject).to receive(:cancel_current_session)
        subject.cancel
      end
    end

    context "when current session does not exist" do
      it "shows related info" do
        expect(InfoScreen).to receive(:no_current_session)
        subject.cancel
      end
    end
  end

  describe "#add_product_batch" do
    context "when product does not included in the list" do
      let(:new_product) { Product.new("Orange", 200) }
      let(:new_batch) { ProductBatch.new(new_product, 10) }

      before do
        subject.add_product_batch(new_batch)
      end

      it "add the product" do
        expect(subject.products["Orange"].amount).to eq 10
      end
    end

    context "when product already exists in the list" do
      let(:new_batch) { ProductBatch.new(default_product_1, 10) }

      before do
        subject.add_product_batch(new_batch)
      end

      it "adds new amount of the product to the existing batch" do
        expect(subject.products["Coca-Cola"].amount).to eq 20
      end
    end
  end
end