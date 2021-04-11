require 'spec_helper'

RSpec.describe ProductBatch do
  let(:default_product) { Product.new("Coca-Cola", 150) }
  let(:default_amount) { 10 }
  subject { described_class.new(default_product, default_amount) }

  describe "#add" do
    context "when additional amount less than 0" do
      it "raises an error" do
        expect { subject.add(-5) }.to raise_error("added amount should be greater than 0")
      end
    end

    context "when additional amount greater than 0" do 
      before do
        subject.add(5)
      end

      it "adds additional amount of products to the batch" do
        expect(subject.amount).to eq 15
      end
    end
  end

  describe "#remove_one_item" do
    context "when amount equals 0 already" do
      let(:default_amount) { 0 }

      it "raises an error" do
        expect { subject.remove_one_item }.to raise_error("the batch of Coca-Cola is already empty")
      end
    end

    context "when amount greater than 0" do
      before do
        subject.remove_one_item
      end

      it "removes one item from the batch" do
        expect(subject.amount).to eq 9
      end
    end
  end 
end